import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScriptureCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String id;

  ScriptureCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.id,
  });

  @override
  _ScriptureCardState createState() => _ScriptureCardState();
}

class _ScriptureCardState extends State<ScriptureCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool(widget.id) ?? false;
    });
  }

  _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool(widget.id, isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
