import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:html/parser.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanatan_dharmaya/pages/donation/donation.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';

import '../../components/Appbar.component.dart';

class Donations extends StatefulWidget {
  const Donations({super.key});

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  List<Map<String, dynamic>> Donations = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final DonationsUrl = Uri.parse(
        'https://sanatandharmaya.com/server/app/donations/all/65f093ed19bdb30a54f75ff2');

    try {
      final DonationsResponse = await http.get(DonationsUrl);

      setState(() {
        Donations = List<Map<String, dynamic>>.from(
            json.decode(DonationsResponse.body).map((item) {
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
    return Column(children: [
      AppbarComponent(
        title: "Donations",
      ),
      if (loading)
        Container(
          margin: EdgeInsets.only(top: 200),
          child: const CircularProgressIndicator(
            color: Colors.orange,
          ),
        ),
      if (loading == false)
        Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Donations.map((donations) {
                    var title = parse(donations['title']!);
                    String parsedString = parse(title.documentElement!.text)
                        .documentElement!
                        .text;
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                  child:
                                      Icon(Icons.keyboard_arrow_right_outlined),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            ))
    ]);
  }
}
