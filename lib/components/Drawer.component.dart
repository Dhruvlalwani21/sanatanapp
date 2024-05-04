import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanatan_dharmaya/utils/CustomImage.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    List<DrawerMenuModel> MenuList = [
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
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: List.generate(
            MenuList.length,
            (index) => ListTile(
                  leading: CustomImageView(
                    border: Border.all(width: 0),
                    imagePath: MenuList[index].icon,
                    height: 35,
                    width: 35,
                  ),
                  title: Text(MenuList[index].name),
                )),
      ),
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
