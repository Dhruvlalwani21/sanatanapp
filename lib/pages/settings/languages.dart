import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int _language = 1;

  @override
  void initState() {
    super.initState();
    _loadlanguage();
  }

  // Loading language value on start
  void _loadlanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = (prefs.getInt('language') ?? 1);
    });
  }

  // language after click
  void _ChangeLanguage(language) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('language', language);
    });
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
          const SizedBox(
            width: 6,
          ),
          Container(
            child: Text(
              "Languages",
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
