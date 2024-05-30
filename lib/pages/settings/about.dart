import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

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
            const SizedBox(
              width: 6,
            ),
            Container(
              child: Text(
                "About",
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 280,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam diam neque, rhoncus ac cursus eu, hendrerit vel purus. Duis interdum eu ante ut scelerisque. Pellentesque suscipit posuere turpis non tempor. Nam viverra augue eu est bibendum facilisis. Etiam fringilla sapien sed dignissim maximus. Nunc ut blandit neque. Nulla lacinia ipsum felis, cursus dictum ante consequat nec. Donec mattis ipsum diam, at volutpat erat rutrum at. Maecenas vel urna vitae tortor rhoncus vestibulum. Duis congue, velit id lobortis consectetur, orci neque consectetur ligula, at mollis leo ipsum vitae velit. Donec hendrerit diam quis nulla viverra suscipit. Pellentesque molestie elementum leo elementum feugiat. Mauris id tortor eu lectus pharetra mollis eget eget lorem. Duis porttitor iaculis mi, vel facilisis massa iaculis vitae. Aliquam fringilla eros convallis neque hendrerit auctor. Nulla ut aliquam tellus. Praesent tortor sem, congue nec interdum eu, finibus sit amet leo. Curabitur sollicitudin arcu diam, et varius nulla rhoncus ut. Vestibulum laoreet a elit et semper. Etiam convallis fringilla massa, elementum posuere augue viverra vel. Quisque condimentum eleifend augue, non imperdiet ex blandit quis. Vestibulum laoreet, lacus a condimentum dignissim, sapien massa porta quam, hendrerit tristique lacus nisl eget nunc. Fusce quis sagittis felis. Aliquam erat volutpat. Vivamus semper nunc vitae pellentesque rhoncus. Suspendisse potenti. Vestibulum sit amet nunc id tortor consequat sollicitudin at non ligula. Curabitur eget urna fermentum, consectetur leo at, commodo mauris. Suspendisse potenti. Donec laoreet purus sed lobortis porttitor.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ]),
        )));
  }
}
