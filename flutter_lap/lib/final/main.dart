import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/courses_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Course> _courses = [
    Course(name: 'HTML'),
    Course(name: 'JAVA'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCORE APP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CoursesView(courses: _courses),
    );
  }
}