import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:html/parser.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanatan_dharmaya/pages/blog/blog.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';

import '../../components/Appbar.component.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  List<Map<String, dynamic>> blogs = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final blogsUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/blogs/all/65f093ed19bdb30a54f75ff2');

    try {
      final blogsResponse = await http.get(blogsUrl);

      setState(() {
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
        loading = false;
      });
    } catch (error) {
      // Handle error
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarComponent(
          title: "Explore",
        ),
        if (loading)
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: const CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
        if (loading == false)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 210, crossAxisCount: 2),
                    children: blogs.map((blog) {
                      var title = parse(blog['title']!);
                      String parsedString = parse(title.documentElement!.text)
                          .documentElement!
                          .text;
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
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                const BoxShadow(
                                    color: Color.fromRGBO(32, 27, 57, 0.08),
                                    spreadRadius: 1,
                                    blurRadius: 40)
                              ]),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      blog['image']!,
                                      width: 150,
                                      height: 115,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10, top: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 35,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
