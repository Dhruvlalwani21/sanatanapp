import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanatan Dharmaya',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _curr_index = 0;
  List BottomBaritems = [itemModal(icon: Icon(Icons.home), name: "Home")];
  List Screens = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(), bottomNavigationBar: _buildBottomBar(context));
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
        items: List.generate(
            4,
            (index) =>
                BottomNavigationBarItem(
                  icon: BottomBaritems[index].icon
                  )
              
                  ));
  }
}

class itemModal {
  final Icon icon;
  final String name;

  itemModal({
    required this.icon,
    required this.name,
  });
}
