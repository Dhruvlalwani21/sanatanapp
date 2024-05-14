import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_dharmaya/pages/categories/category.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sanatan_dharmaya/utils/imageHandler.dart';
import '../../components/Appbar.component.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> categories = [];
  bool loading = true;
  String Language = '65f093ed19bdb30a54f75ff2';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final categoriesUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/category/main/' + Language);

    try {
      final categoriesResponse = await http.get(categoriesUrl);
      setState(() {
        categories = List<Map<String, dynamic>>.from(
            json.decode(categoriesResponse.body).map((item) {
          return {
            'id': item['_id'] as String,
            'name': item['Name'] as String,
            'icon': item['Icon'] as String,
            'Colorleft': item['Colorleft'] as String,
            'Colorright': item['Colorright'] as String,
            'Headfontcolor': item['Headfontcolor'] as String,
            'count': item['pagesCount'] as int,
          };
        }));

        loading = false;
      });
    } catch (error) {
      // Handle error
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppbarComponent(
            title: "Category",
          ),
          if (loading)
            Container(
              margin: EdgeInsets.only(top: 200),
              child: const CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          if (loading == false) CategorySection(categories: categories),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  CategorySection({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Pages(
                                categorytitle: category['name']!,
                                categoryid: category['id']!,
                              )),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 7),
                    alignment: Alignment.center,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              fromCssColor(category['Colorleft']!),
                              fromCssColor(category['Colorright']!),
                            ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name']!,
                                style: TextStyle(
                                    color: fromCssColor(
                                        category['Headfontcolor']!),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              Text(
                                category['count']!.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 56,
                          width: 56,
                          child: category['icon']!.isNotEmpty
                              ? imageHandler(image: category['icon']!)
                              // ? Image.network(category['icon']!)
                              : null,
                        )
                      ],
                    ),
                  ),
                );
              }).toList()
                  //   ListTile(
                  //     leading: category['icon']!.isNotEmpty
                  //         ? Image.network(category['icon']!)
                  //         : null,
                  //     title: Text(category['name']!),
                  //   );
                  // }).toList(),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
