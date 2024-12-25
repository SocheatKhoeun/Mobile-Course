import 'package:flutter/material.dart';
import 'package:flutter_lap/final2/widgets/course_view.dart';
import '../../final2/models/course.dart';
class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScoreApp(),
    );
  }
}

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    List<Course> courses = [
      Course('HTML', [
        StudentScore('Ronan the best', 85.0),
        StudentScore('Vichey cry', 75.0),
        StudentScore('Sokea Amazon', 70.0),
      ]),
      Course('JAVA', []),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCORE APP'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: courses.map((course) {
            return CourseCard(course: course);
          }).toList(),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseView(course: course),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 8),
              Text(
                'Scores: ${course.scores.isNotEmpty ? course.scores.length.toString() : 'No scores'}',
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 8),
              Text(
                'Average: ${course.averageScore != null ? course.averageScore!.toStringAsFixed(1) : 'No average'}',
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 16),
              if (course.scores.isEmpty) ...[
                const Text('No score',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
