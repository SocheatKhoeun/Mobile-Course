import 'package:flutter/material.dart';
import '../models/course.dart';
import 'course_view.dart';

class CoursesView extends StatefulWidget {
  final List<Course> courses;

  const CoursesView({Key? key, required this.courses}) : super(key: key);

  @override
  _CoursesViewState createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          final course = widget.courses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: ListTile(
              title: Text(
                course.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Scores: ${course.numberOfScores}\nAvg: ${course.averageScore.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseView(
                      course: course,
                      onCourseUpdated: () {
                        setState(() {}); 
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}