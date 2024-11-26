import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onDeleteExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDeleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          title: Text(expense.title),
          subtitle: Text('${expense.amount.toStringAsFixed(2)} USD | ${expense.category.name}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDeleteExpense(expense),
          ),
        );
      },
    );
  }
}
