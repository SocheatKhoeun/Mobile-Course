import 'package:flutter/material.dart';
import 'package:flutter_lap/W6-S2/model/quiz.dart';


class QuestionScreen extends StatelessWidget {
  final Question question;
  final Function(String) onAnswerSelected;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the question title
            Text(
              question.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Display possible answers as buttons
            ...question.possibleAnswers.map((answer) {
              return ElevatedButton(
                onPressed: () => onAnswerSelected(answer),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
