import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final Border border;

  const CustomImageView({
    required this.imagePath,
    required this.height,
    required this.width,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height, width: width, child: SvgPicture.asset(imagePath));
  }
}
