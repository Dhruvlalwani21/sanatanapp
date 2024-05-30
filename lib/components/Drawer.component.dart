import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanatan_dharmaya/pages/settings/disclaimer.dart';
import 'package:sanatan_dharmaya/pages/settings/languages.dart';
import 'package:sanatan_dharmaya/pages/settings/tnc.dart';
import 'package:sanatan_dharmaya/pages/settings/about.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Future PageRedirector(context, Page) {
      return Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  Page));
    }

    List<DrawerMenuModel> menuList = [
      DrawerMenuModel(icon: 'assets/icons/collection.svg', name: "Collection"),
      DrawerMenuModel(icon: 'assets/icons/heart-red.svg', name: "Wishlist"),
      DrawerMenuModel(icon: 'assets/icons/history.svg', name: "History"),
      DrawerMenuModel(icon: 'assets/icons/new.svg', name: "What's New"),
      DrawerMenuModel(icon: 'assets/icons/edit.svg', name: "Profile"),
      DrawerMenuModel(icon: 'assets/icons/lock.svg', name: "Password"),
      DrawerMenuModel(icon: 'assets/icons/mail.svg', name: "Change Email"),
      DrawerMenuModel(icon: 'assets/icons/phone.svg', name: "Change Phone No."),
      DrawerMenuModel(
          icon: 'assets/icons/bell-fill.svg', name: "Notifications"),
      DrawerMenuModel(icon: 'assets/icons/language.svg', name: "Languages"),
      DrawerMenuModel(icon: 'assets/icons/video.svg', name: "Audio/Video"),
      DrawerMenuModel(icon: 'assets/icons/playback.svg', name: "Playback"),
      DrawerMenuModel(
          icon: 'assets/icons/storage.svg', name: "Data Saver Storage"),
      DrawerMenuModel(icon: 'assets/icons/faq.svg', name: "FAQ"),
      DrawerMenuModel(
          icon: 'assets/icons/customer.svg', name: "Customer Support"),
      DrawerMenuModel(icon: 'assets/icons/about.svg', name: "About us"),
      DrawerMenuModel(
          icon: 'assets/icons/terms.svg', name: "Terms & Conditions"),
      DrawerMenuModel(icon: 'assets/icons/warn.svg', name: "Disclaimer"),
      DrawerMenuModel(icon: 'assets/icons/social.svg', name: "Social Media"),
      DrawerMenuModel(
          icon: 'assets/icons/feedback.svg', name: "FeedBack/Suggestions"),
      DrawerMenuModel(icon: 'assets/icons/rate.svg', name: "Rate App"),
    ];

    return Drawer(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: CustomImageView(
                      border: Border.all(width: 0),
                      imagePath: "assets/imgs/logo.svg",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomImageView(
                      border: Border.all(width: 0),
                      imagePath: "assets/icons/menu.svg",
                      height: 45,
                      width: 45,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:
                          Container(color: Colors.grey, width: 60, height: 60),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Username",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            )),
                        Text("user@email.com",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14.0,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 5, top: 15),
            child: Text("General",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[0].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[0].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[1].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[1].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[2].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[2].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[3].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[3].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 5, top: 15),
            child: Text("Account Settings",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[4].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[4].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[5].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[5].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[6].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[6].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[7].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[7].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 5, top: 15),
            child: Text("App Settings",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[8].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[8].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            onTap: () {
              PageRedirector(context, Language());
            },
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[9].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[9].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[10].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[10].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[11].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[11].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[12].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[12].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 5, top: 15),
            child: Text("Support",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[13].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[13].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[14].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[14].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 5, top: 15),
            child: Text("Information",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
          ListTile(
            onTap: () {
              PageRedirector(context, About());
            },
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[15].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[15].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            onTap: () {
              PageRedirector(context, Tnc());
            },
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[16].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[16].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            onTap: () {
              PageRedirector(context, Disclaimer());
            },
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[17].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[17].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[18].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[18].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[19].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[19].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 221, 221, 221))))),
          ListTile(
            leading: CustomImageView(
              border: Border.all(width: 0),
              imagePath: menuList[20].icon,
              height: 35,
              width: 35,
            ),
            title: Text(
              menuList[20].name,
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ])
      ]),
    );
  }
}

class DrawerMenuModel {
  DrawerMenuModel({
    required this.icon,
    required this.name,
  });
  String icon;
  String name;
}
