import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class imageHandler extends StatelessWidget {
  const imageHandler({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return (image.contains('.svg')
        ? SvgPicture.network(image)
        : Image.network(image));
  }
}
