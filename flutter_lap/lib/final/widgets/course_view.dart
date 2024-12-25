import 'package:flutter/material.dart';
import '../models/course.dart';
import 'score_form.dart';

class CourseView extends StatefulWidget {
  final Course course;
  final VoidCallback onCourseUpdated;

  const CourseView({Key? key, required this.course, required this.onCourseUpdated}) : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  void _addScore(StudentScore newScore) {
    setState(() {
      widget.course.scores.add(newScore);
    });
    widget.onCourseUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.course.name),
        actions: [
          IconButton(
            onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScoreForm(),
              ),
            );  

            if (result != null && result is StudentScore) {
              _addScore(result);
            }
          },
          icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: widget.course.scores.isEmpty
          ? const Center(child: Text('No scores added yet.'))
          : ListView.builder(
              itemCount: widget.course.scores.length,
              itemBuilder: (context, index) {
                final score = widget.course.scores[index];
                final color = score.score > 50
                    ? Colors.green
                    : (score.score >= 30 ? Colors.orange : Colors.red);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: ListTile(
                    title: Text(score.studentName),
                    trailing: Text(
                      score.score.toString(),
                      style: TextStyle(color: color, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

