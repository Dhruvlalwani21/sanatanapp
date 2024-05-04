import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanatan_dharmaya/pages/pagestyles/aarti.dart';

class AartiCard extends StatelessWidget {
  const AartiCard(
      {super.key,
      required this.image,
      required this.category,
      required this.color,
      required this.title,
      required this.id});
  final String id;
  final String image;
  final String category;
  final String color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Aarti(
                    image: image.toString(),
                    link:
                        'https://sanatandharmaya.com/server/app/pages/aarti/$id',
                    category: category,
                    color: color,
                  )),
        );
      },
      child: Container(
        width: 166,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(32, 27, 57, 0.08),
                  spreadRadius: 1,
                  blurRadius: 40)
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Column(
          children: [
            if (image != '')
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    image,
                    width: 150,
                    height: 115,
                    fit: BoxFit.fill,
                  )),
            if (image == '')
              SizedBox(
                height: 115,
              ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: SizedBox(
                width: 120,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
