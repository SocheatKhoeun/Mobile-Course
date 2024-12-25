import 'package:flutter/material.dart';
import '../widgets/score_form.dart';
import '../../final2/models/course.dart';

class CourseView extends StatefulWidget {
  final Course course;

  const CourseView({required this.course, super.key});

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.course.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScoreForm(course: widget.course),
                ),
              );
              _refresh();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.course.scores.length,
                itemBuilder: (context, index) {
                  final studentScore = widget.course.scores[index];
                  return StudentScoreWidget(studentScore: studentScore);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentScoreWidget extends StatelessWidget {
  final StudentScore studentScore;

  const StudentScoreWidget({required this.studentScore, super.key});

  @override
  Widget build(BuildContext context) {
    Color scoreColor;

    // Color the score
    if (studentScore.score >= 75) {
      scoreColor = Colors.green; // Good score
    } else if (studentScore.score >= 50) {
      scoreColor = Colors.orange; // Average score
    } else {
      scoreColor = Colors.red; // lower score
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(studentScore.name),
          Text(
            '${studentScore.score}',
            style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
