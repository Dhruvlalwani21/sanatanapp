import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Profile"),
        ),
        Center(
            child: Text(
          "User Not Logged In, Please Login with valid username and password",
          style: TextStyle(fontSize: 30),
        ))
      ],
    );
  }
}
