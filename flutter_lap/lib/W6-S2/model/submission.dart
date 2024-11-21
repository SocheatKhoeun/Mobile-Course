import 'package:flutter_lap/W6-S2/model/quiz.dart';

class Answer {
  final String answer;
  Answer({required this.answer});

  bool isCorrectAnswer(Question question) => question.goodAnswer == answer;
}

class Submission {
  final Map<Question, String> _answers = {};

  int getScore(List<Question> questions) {
    int score = 0;
    for (var question in questions) {
      if (_answers[question] == question.goodAnswer) {
        score++;
      }
    }
    return score;
  }

  String? getAnswerFor(Question question) {
    return _answers[question];
  }

  void addAnswer(Question question, String answer) {
    if (answer.isEmpty) {
      throw ArgumentError("Answer cannot be empty.");
    }
    _answers[question] = answer;
  }

  void removeAnswer(Question question) {
    _answers.remove(question);
  }
}
