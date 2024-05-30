import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/CustomImage.dart';

class AppbarComponent extends StatelessWidget {
  final String title;
  const AppbarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: CustomImageView(
            border: Border.all(width: 0),
            imagePath: "assets/icons/menu.svg",
            height: 25,
            width: 25,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: CustomImageView(
                    border: Border.all(width: 0),
                    imagePath: "assets/icons/bell.svg",
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: CustomImageView(
                    border: Border.all(width: 0),
                    imagePath: "assets/icons/heart-outline.svg",
                    height: 40,
                    width: 40,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
