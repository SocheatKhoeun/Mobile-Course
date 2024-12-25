class Course {
  final String name;
  final List<StudentScore> scores;

  Course(this.name, this.scores);

  int get Scores => scores.length;

  double? get averageScore {
    if (scores.isEmpty) return null;
    double total = scores.fold(0, (sum, score) => sum + score.score);
    return total/scores.length;
  }
}

class StudentScore {
  final String name;
  final double score;

  StudentScore(this.name, this.score);
}