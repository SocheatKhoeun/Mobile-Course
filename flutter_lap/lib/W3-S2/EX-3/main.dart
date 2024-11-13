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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20), 
                  child: _GradientContainer('OOP', Colors.blue[100]!),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: _GradientContainer('DART', Colors.blue[300]!),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: _GradientContainer('FLUTTER', Colors.blue[600]!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _GradientContainer(String text, Color color) {
    return Container(
      width: 900,
      height: 50,
      decoration: BoxDecoration(
        color: color,
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