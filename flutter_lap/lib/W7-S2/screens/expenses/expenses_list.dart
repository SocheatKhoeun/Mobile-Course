import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  Widget? buildItem(BuildContext context, int index) {
    print("WE are building the item $index");

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      color: Colors.orange,
      height: 200,
      child: Text("$index - ${expenses[index].title}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: buildItem,
    );
  }
}
