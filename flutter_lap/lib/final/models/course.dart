class Course {
  final String name;
  List<StudentScore> scores;

  Course({required this.name, this.scores = const []});

  double get averageScore {
    if (scores.isEmpty) {
      return 0; 
    }

    double totalScore = 0;
    for (var score in scores) {
      totalScore += score.score;
    }

    return totalScore / scores.length;
  }

  int get numberOfScores => scores.length;
}

class StudentScore {
  final String studentName;
  final int score;

  StudentScore({required this.studentName, required this.score});
}