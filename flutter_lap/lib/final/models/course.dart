class Course {
  final String name;
  List<StudentScore> scores;

  Course({required this.name, this.scores = const []});

  double get averageScore {
    if (scores.isEmpty) return 0;
    return scores.map((e) => e.score).reduce((a, b) => a + b) / scores.length;
  }

  int get numberOfScores => scores.length;
}

class StudentScore {
  final String studentName;
  final int score;

  StudentScore({required this.studentName, required this.score});
}