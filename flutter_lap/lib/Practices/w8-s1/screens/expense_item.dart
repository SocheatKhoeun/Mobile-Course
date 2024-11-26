//screen/expense_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_lap/Practices/w8-s1/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text('${expense.amount.toStringAsFixed(2)} USD'),
    );
  }
}
