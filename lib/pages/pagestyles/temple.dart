import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_dharmaya/utils/CustomImage.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:latlong2/latlong.dart';

class Temple extends StatefulWidget {
  final String link;
  final String image;
  final String category;
  final String color;
  const Temple(
      {super.key,
      required this.link,
      required this.image,
      required this.category,
      required this.color});
  @override
  _TempleState createState() => _TempleState();
}

class _TempleState extends State<Temple> {
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
          if (data.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                parse(parse(data['title']!).documentElement!.text)
                    .documentElement!
                    .text,
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ]),
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 370.0,
                floating: false,
                collapsedHeight: 20,
                toolbarHeight: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 0),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          if (widget.image == "")
                            Container(
                              height: 250,
                            ),
                          if (widget.image != "")
                            ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  widget.image,
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.fill,
                                )),
                        ],
                      )),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                      ),
                      tabs: const [
                        Tab(text: 'Description'),
                        Tab(text: 'Time'),
                        Tab(text: 'Travel'),
                        Tab(text: 'Media'),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  child: _buildview1(BuildContext, context)),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Timings",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (data.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: data['timings']!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(54, 76, 175, 79),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              data['timings'][index]["label"]!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "From: ${data['timings'][index]["from"]!}"),
                                          SizedBox(width: 4),
                                          Text(
                                              "To: ${data['timings'][index]["to"]!}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ]))),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildview2(BuildContext, context)),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Media",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (data.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: data['video']!.length,
                          itemBuilder: (context, index) {
                            return VideoPlayerWidget(
                                videoUrl: data['video'][index]);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildview1(BuildContext, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (data.isNotEmpty)
            Text(
              parse(parse(data['title']!).documentElement!.text)
                  .documentElement!
                  .text,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  widget.category,
                  style: const TextStyle(
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
                          icon: const Icon(
                            Icons.share,
                            color: Color.fromARGB(255, 50, 0, 168),
                            size: 23,
                          )),
                    ),
                    const SizedBox(
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
          if (data.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(data['description']!)),
          if (data.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(data['innertitle']!)),
          if (data.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(data['innerdescription']!)),
          if (data.isNotEmpty)
            if (data.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(data['middletitle']!)),

          if (data.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(data['middledescription']!)),
          if (data.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(data['middleinfo']!)),

          // You can similarly display other data such as documents, etc.
        ],
      ),
    );
  }

  _buildview2(BuildContext, context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 20,
        ),

        if (data.isNotEmpty)
          if (data['lat'] != '' || data['long'] != '')
          Container()
            else Container(
              child: FlutterMap(
                options: MapOptions(
                    initialCenter: LatLng(data['lat']!, data['long']!),
                    initialZoom: 11,
                    interactionOptions: const InteractionOptions(
                        flags: ~InteractiveFlag.doubleTapDragZoom)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.sanatandharmaya.app',
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                      ),
                    ],
                  ),
                ],
              ),
            )
        // You can similarly display other data such as documents, etc.
      ]),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl)));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: FlickVideoPlayer(
          flickManager: flickManager,
        ),
      ),
    );
  }
}
