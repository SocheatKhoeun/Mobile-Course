import 'package:uuid/uuid.dart';

enum NoteCategory { Reminder, Idea, Study, Others }

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime modifiedTime;
  final NoteCategory category;

  Note({
    required this.title,
    required this.content,
    required this.modifiedTime,
    required this.category, 
  }): id = const Uuid().v4();
}

List<Note> sampleNotes = [
  Note(
    title: 'Upcoming Project Deadlines',
    content:
        '1. Software Engineering Project: March 10, 2024\n2. Data Structures and Algorithms Homework: March 15, 2024\n3. Web Development Final Project: April 1, 2024\n4. Database Design Report: April 10, 2024',
    modifiedTime: DateTime(2024, 2, 5, 10, 0),
    category: NoteCategory.Study,
  ),
  Note(
    title: 'Programming Language Practice Schedule',
    content:
        'Monday: Python (10 AM - 12 PM)\nTuesday: JavaScript (2 PM - 4 PM)\nWednesday: C++ (1 PM - 3 PM)\nThursday: SQL (3 PM - 5 PM)',
    modifiedTime: DateTime(2024, 2, 10, 8, 0),
    category: NoteCategory.Reminder,
  ),
  Note(
    title: 'Tech Conference Schedule',
    content:
        '1. AI and Machine Learning Summit: March 5-6, 2024\n2. Cloud Computing Workshop: March 20, 2024\n3. Web Development Hackathon: April 12, 2024',
    modifiedTime: DateTime(2024, 2, 10, 9, 0),
    category: NoteCategory.Reminder,
  ),
  Note(
    title: 'Study Tips for Programming',
    content:
        '1. Practice coding daily on platforms like LeetCode or HackerRank\n2. Break down complex problems into smaller steps\n3. Collaborate with peers on coding challenges and review each other’s code\n4. Focus on understanding algorithms and their applications in real-world scenarios',
    modifiedTime: DateTime(2024, 2, 15, 14, 30),
    category: NoteCategory.Idea,
  ),
  Note(
    title: 'Technology Course Schedule',
    content:
        'Monday: Data Structures and Algorithms (9 AM - 11 AM)\nTuesday: Web Development (10 AM - 12 PM)\nWednesday: Operating Systems (1 PM - 3 PM)\nFriday: Software Engineering (9 AM - 11 AM)',
    modifiedTime: DateTime(2024, 2, 10, 8, 0),
    category: NoteCategory.Reminder,
  ),
];
