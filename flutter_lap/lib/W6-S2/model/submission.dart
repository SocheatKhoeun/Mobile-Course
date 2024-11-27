import 'package:flutter_lap/W6-S2/model/quiz.dart';

class Answer {
  final String answer;

  Answer({required this.answer});

  bool isCorrect(Question question) => question.goodAnswer == answer;
}

class Submission {
  final Map<Question, String> _answers = {};
  final List<Question> questions;

  Submission({required this.questions});

  int getScore() {
    int score = 0;
    for (var question in questions) {
      final answer = _answers[question];
      if (answer != null && Answer(answer: answer).isCorrect(question)) {
        score++;
      }
    }
    return score;
  }


  Answer? getAnswerFor(Question question) {
    final answer = _answers[question];
    return answer != null ? Answer(answer: answer) : null;
  }

  void addAnswer(Question question, String answer) {
    _answers[question] = answer;
  }

  void removeAnswers() {
    _answers.clear();
  }
}
