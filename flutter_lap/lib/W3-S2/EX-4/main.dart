import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCard(
                  text: 'OOP',
                  color: Colors.blue[100]!,
                ),
                CustomCard(
                  text: 'DART',
                  color: Colors.blue[300]!,
                ),
                CustomCard(
                  text: 'FLUTTER',
                  color: Colors.blue[600]!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String text;
  final Color? color;
  final Gradient? gradient;

  const CustomCard({
    super.key,
    required this.text,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 900,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,  
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
