import 'package:flutter/material.dart';
import 'package:flutter_lap/final2/widgets/courses_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursesView(),
    );
  }
}
