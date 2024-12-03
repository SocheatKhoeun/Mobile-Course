import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseRemoved,
  });

  final List<Expense> expenses;
  final Function(Expense) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? Center(
            child: Text(
              "No expenses found. Start adding some!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(expenses[index].id),
                onDismissed: (direction) {
                  onExpenseRemoved(expenses[index]);
                },
                child: ExpenseItem(expenses[index]),
              ),
            ),
          );
  }
}
