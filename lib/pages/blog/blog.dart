import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_dharmaya/utils/CustomImage.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:html/parser.dart';

class Blog extends StatefulWidget {
  final String link;
  final String image;
  final String category;
  final String color;
  const Blog(
      {super.key,
      required this.link,
      required this.image,
      required this.category,
      required this.color});
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  Map<String, dynamic> data = {};
  String text = 'Hi check this out at https://sanatandharmaya.com/';
  String subject = 'Hi i have found a great app check this out';
  String uri = '';

  sharehandler() {
    Share.share(text, subject: subject);
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(widget.link));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            SizedBox(
              width: 6,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(52, 255, 153, 0),
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.image,
                      width: 280,
                      height: 280,
                      fit: BoxFit.fill,
                    )),
              ),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  parse(parse(data['title']!).documentElement!.text)
                      .documentElement!
                      .text,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      widget.category,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(38, 104, 58, 183)),
                          child: IconButton(
                              onPressed: sharehandler,
                              icon: Icon(
                                Icons.share,
                                color: Color.fromARGB(255, 50, 0, 168),
                                size: 23,
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomImageView(
                            imagePath: 'assets/icons/heart-red.svg',
                            height: 42,
                            width: 42,
                            border: Border.all(width: 0))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  if (data.isNotEmpty)
                    Text(
                      parse(parse(data['innertitle']!).documentElement!.text)
                          .documentElement!
                          .text,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                  if (data.isNotEmpty)
                    Text(
                      parse(parse(data['innerdescription']!)
                              .documentElement!
                              .text)
                          .documentElement!
                          .text,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                  if (data.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        parse(parse(data['middletitle']!).documentElement!.text)
                            .documentElement!
                            .text,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  if (data.isNotEmpty)
                    Text(
                      parse(parse(data['middledescription']!)
                              .documentElement!
                              .text)
                          .documentElement!
                          .text,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            )
            // You can similarly display other data such as documents, etc.
          ],
        ));
  }
}
