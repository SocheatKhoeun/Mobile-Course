import 'package:flutter/material.dart';
import 'package:flutter_lap/W7-S2/models/expense.dart';
import 'package:flutter_lap/W7-S2/screens/expenses_form.dart';
import 'expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _onExpenseRemoved(Expense expense) {
    final int removedIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Show Snackbar with Undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(removedIndex, expense);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _onExpenseCreated(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(onCreated: _onExpenseCreated),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _onAddPressed,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ExpensesList(
        expenses: _registeredExpenses,
        onExpenseRemoved: _onExpenseRemoved,
      ),
    );
  }
}
