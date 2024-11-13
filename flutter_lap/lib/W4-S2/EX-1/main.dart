import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Hobbies',
      home: HobbyCardBuild(),
    );
  }
}

class HobbyCardBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Hobbies")),
      body: Container(
        color: Colors.grey[700],
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            HobbyCard(
              title: "Travelling",
              icon: Icons.travel_explore,
              backgroundColor: Colors.green,
              iconPadding: EdgeInsets.all(40),
              borderRadius: 40,
            ),
            SizedBox(height: 10),
            HobbyCard(
              title: "Skating",
              icon: Icons.skateboarding,
              backgroundColor: Colors.blueGrey,
              iconPadding: EdgeInsets.all(40),
              borderRadius: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final EdgeInsets iconPadding;
  final double borderRadius;

  const HobbyCard({
    required this.title,
    required this.icon,
    this.backgroundColor = Colors.blue,
    this.iconPadding = const EdgeInsets.all(8),
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: iconPadding,
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
