import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_dharmaya/components/cards/pagecard.dart';

class Pages extends StatefulWidget {
  const Pages({required this.categorytitle, required this.categoryid});
  final String categorytitle;
  final String categoryid;
  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  List<Map<String, dynamic>> pages = [];
  bool loading = true;
  String Language = '65f093ed19bdb30a54f75ff2';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final aartiUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/pages/aarti/all/$Language/${widget.categoryid}');

    final templeUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/pages/temples/all/$Language/${widget.categoryid}');
    final blogsUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/pages/blogs/all/$Language/${widget.categoryid}');
    final extraUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/pages/extra/all/$Language/${widget.categoryid}');

    try {
      final aartiResponse = await http.get(aartiUrl);
      final templeResponse = await http.get(templeUrl);
      final blogsResponse = await http.get(blogsUrl);
      final extraResponse = await http.get(extraUrl);
      List<dynamic> combinedResponses = [];
      combinedResponses.addAll(json.decode(aartiResponse.body));
      combinedResponses.addAll(json.decode(templeResponse.body));
      combinedResponses.addAll(json.decode(blogsResponse.body));
      combinedResponses.addAll(json.decode(extraResponse.body));

      setState(() {
        pages = combinedResponses.map((item) {
          return {
            'title': item['title'] as String,
            'image': item['page'][0]['image'] as String,
            'style': item['page'][0]['pagestyle'] as String,
            'category': item['page'][0]['categoryname'][0]['Name'] as String,
            'catid': item['page'][0]['categoryname'][0]['_id'] as String,
            'color':
                item['page'][0]['categoryname'][0]['Headfontcolor'] as String,
            'id': item['_id'] as String,
          };
        }).toList();
        loading = false;
      });
    } catch (error) {
      // Handle error
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Row(children: [
              const SizedBox(
                width: 6,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(52, 255, 153, 0),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.categorytitle,
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]),
          ),
          if (loading)
            const CircularProgressIndicator(
              color: Colors.orange,
            ),
          if (loading == false)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    children: pages.map((data) {
                      var title = parse(data['title']!);
                      String parsedString = parse(title.documentElement!.text)
                          .documentElement!
                          .text;
                      return PageCard(
                        image: data['image']!,
                        category: data['category']!,
                        color: data['color']!,
                        title: parsedString,
                        id: data['id']!,
                        style: data['style']!,
                        catid: data['catid']!,
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
