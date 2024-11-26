import 'package:uuid/uuid.dart';

enum ExpenseType { FOOD, TRAVEL, LEISURE, WORK }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = const Uuid().v4();
}