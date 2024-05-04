import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:html/parser.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanatan_dharmaya/components/Appbar.component.dart';
import 'package:sanatan_dharmaya/components/Drawer.component.dart';
import 'package:sanatan_dharmaya/pages/blog/blog.dart';
import 'package:sanatan_dharmaya/pages/donation/donation.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';
import 'package:sanatan_dharmaya/pages/categories/category.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> bannerImages = [];
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> blogs = [];
  List<Map<String, dynamic>> Donations = [];
  bool loading = true;
  String Language = '65f093ed19bdb30a54f75ff2';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace 'your_api_endpoint' with your actual API endpoint URLs
    final bannerUrl = Uri.parse('https://sanatandharmaya.com/server/hero');
    final categoriesUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/category/main/' + Language);
    final blogsUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/blogs/all/' + Language);

    final DonationsUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/donations/all/65f093ed19bdb30a54f75ff2');

    try {
      final bannerResponse = await http.get(bannerUrl);
      final categoriesResponse = await http.get(categoriesUrl);
      final blogsResponse = await http.get(blogsUrl);
      final donationsResponse = await http.get(DonationsUrl);

      setState(() {
        bannerImages = List<Map<String, String>>.from(
            json.decode(bannerResponse.body).map((item) {
          return {
            'image': item['Image'] as String,
          };
        }));

        categories = List<Map<String, dynamic>>.from(
            json.decode(categoriesResponse.body).map((item) {
          return {
            'name': item['Name'] as String,
            'icon': item['Icon'] as String,
            'count': item['pagesCount'] as int,
          };
        }));
        blogs = List<Map<String, dynamic>>.from(
            json.decode(blogsResponse.body).map((item) {
          return {
            'id': item['_id'] as String,
            'title': item['title'] as String,
            'image': item['page'][0]['image'] as String,
            'category': item['page'][0]['categoryname'][0]['Name'] as String,
            'color':
                item['page'][0]['categoryname'][0]['Headfontcolor'] as String,
          };
        }));
        Donations = List<Map<String, dynamic>>.from(
            json.decode(donationsResponse.body).map((item) {
          return {
            'id': item['_id'] as String,
            'title': item['title'] as String,
            'goal': item['goal'] as String,
            'description': item['description'] as String,
            'image': item['page'][0]['image'] as String,
            'category': item['page'][0]['categoryname'][0]['Name'] as String,
            'color':
                item['page'][0]['categoryname'][0]['Headfontcolor'] as String,
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
            title: "",
          ),
          if (loading)
            Container(
              margin: EdgeInsets.only(top: 200),
              child: const CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          if (loading == false)
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                BannerCarousel(images: bannerImages),
                SizedBox(
                  height: 20,
                ),
                CategorySection(categories: categories),
                BlogsSection(blogs: blogs),
                DonationsSection(donations: Donations),
              ],
            )
        ],
      ),
    );
  }
}

class BannerCarousel extends StatelessWidget {
  final List<Map<String, String>> images;

  BannerCarousel({required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(image['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
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
        Container(
          margin: EdgeInsets.only(left: 15, top: 6),
          alignment: Alignment.centerLeft,
          child: Text(
            'All Categories',
            style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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
                              const Color.fromARGB(255, 255, 99, 88),
                              const Color.fromARGB(255, 255, 157, 157)
                            ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name']!,
                                style: TextStyle(
                                    color: Colors.white,
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
                              ? Image.network(category['icon']!)
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

class DonationsSection extends StatelessWidget {
  final List<Map<String, dynamic>> donations;

  DonationsSection({required this.donations});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(left: 15, top: 6),
        alignment: Alignment.centerLeft,
        child: Text(
          'Donations',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: donations.map((donations) {
                var title = parse(donations['title']!);
                String parsedString =
                    parse(title.documentElement!.text).documentElement!.text;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Donation(
                                image: donations['image']!,
                                link:
                                    'https://sanatandharmaya.com/server/app/donations/' +
                                        donations['id']!,
                                category: donations['category']!,
                                color: donations['color']!,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromRGBO(32, 27, 57, 0.08),
                              spreadRadius: 1,
                              blurRadius: 40)
                        ]),
                    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              donations['image']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      parsedString,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      donations['category'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      parse(parse(donations['description']!)
                                              .documentElement!
                                              .text)
                                          .documentElement!
                                          .text,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          "Goal:" + donations['goal']!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromARGB(82, 255, 109, 158)),
                              child: Icon(Icons.keyboard_arrow_right_outlined),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()))
    ]);
  }
}

class BlogsSection extends StatelessWidget {
  final List<Map<String, dynamic>> blogs;

  BlogsSection({required this.blogs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, top: 6),
          alignment: Alignment.centerLeft,
          child: Text(
            'Blogs',
            style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: blogs.map((blog) {
                  var title = parse(blog['title']!);
                  String parsedString =
                      parse(title.documentElement!.text).documentElement!.text;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Blog(
                                  image: blog['image']!,
                                  link:
                                      'https://sanatandharmaya.com/server/app/blogs/' +
                                          blog['id']!,
                                  category: blog['category']!,
                                  color: blog['color']!,
                                )),
                      );
                    },
                    child: Container(
                      width: 166,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromRGBO(32, 27, 57, 0.08),
                                spreadRadius: 1,
                                blurRadius: 40)
                          ]),
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                blog['image']!,
                                width: 150,
                                height: 115,
                                fit: BoxFit.fill,
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    parsedString,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    blog['category'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 35,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: SizedBox(
                                width: 120,
                                child: Text(
                                  "Read More",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ))
      ],
    );
  }
}
