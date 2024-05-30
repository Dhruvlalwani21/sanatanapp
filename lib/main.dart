import 'package:flutter/material.dart';
import 'package:sanatan_dharmaya/components/Drawer.component.dart';
import 'package:sanatan_dharmaya/pages/blog/blogs.dart';
import 'package:sanatan_dharmaya/pages/categories/categories.dart';
import 'package:sanatan_dharmaya/pages/donation/donations.dart';
import 'package:sanatan_dharmaya/pages/home/homepage.dart';
import 'package:sanatan_dharmaya/pages/settings/settings.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanatan Dharmaya',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        primaryTextTheme: textTheme,
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedindex = 0;
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
        activeicon: 'assets/icons/bottom/homebold.svg',
        icon: 'assets/icons/bottom/home.svg',
        color: Colors.amber),
    BottomMenuModel(
        activeicon: 'assets/icons/bottom/bookbold.svg',
        icon: 'assets/icons/bottom/book.svg',
        color: const Color.fromARGB(255, 3, 0, 204)),
    BottomMenuModel(
        activeicon: 'assets/icons/bottom/charitybold.svg',
        icon: 'assets/icons/bottom/charity.svg',
        color: Colors.lightBlue),
    BottomMenuModel(
        activeicon: 'assets/icons/bottom/blogbold.svg',
        icon: 'assets/icons/bottom/Blog.svg',
        color: const Color.fromARGB(255, 0, 155, 26)),
    BottomMenuModel(
        activeicon: 'assets/icons/bottom/userbold.svg',
        icon: 'assets/icons/bottom/user.svg',
        color: Colors.redAccent)
  ];
  List<Widget> Pages = [Home(), Categories(), Donations(), Blogs(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerComponent(),
        body: Pages[_selectedindex],
        bottomNavigationBar: Container(
          height: 62,
          decoration: BoxDecoration(
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(
                  0,
                  -4,
                ),
              ),
            ],
          ),
          child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              elevation: 0,
              currentIndex: _selectedindex,
              type: BottomNavigationBarType.fixed,
              items: List.generate(
                bottomMenuList.length,
                (index) => BottomNavigationBarItem(
                  icon: CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 25,
                    width: 25,
                    border: Border.all(width: 0),
                  ),
                  activeIcon: Container(
                    padding: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: bottomMenuList[index].color, width: 3))),
                    child: CustomImageView(
                      imagePath: bottomMenuList[index].activeicon,
                      height: 25,
                      width: 25,
                      border: Border.all(width: 0),
                    ),
                  ),
                  label: '',
                ),
              ),
              onTap: (index) => setState(() {
                    _selectedindex = index;
                  })),
        ));
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.color,
    required this.activeicon,
  });
  String icon;
  String activeicon;
  Color color;
}
