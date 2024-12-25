import 'package:flutter/material.dart';
import 'package:flutter_lap/final2/models/course.dart';

class ScoreForm extends StatefulWidget {
  final Course course;

  const ScoreForm({required this.course, super.key});

  @override
  _ScoreFormState createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _studentName = '';
  double? _score;

  void _addScore() {
    if (_formKey.currentState!.validate()) {
      widget.course.scores.add(StudentScore(_studentName, _score!));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Must be between 3 and 30 characters';
                  }
                  return null;
                },
                onChanged: (value) {
                  _studentName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a score';
                  }
                  final score = double.tryParse(value);
                  if (score == null || score < 0 || score > 100) {
                    return 'Must be between 0 and 100';
                  }
                  _score = score;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addScore,
                child: const Text('Add Score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}