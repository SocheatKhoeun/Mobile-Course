import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expense.dart';
import 'expense_list.dart';

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
      category: ExpenseType.LEISURE,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: ExpenseType.LEISURE,
    ),
  ];

  void _openAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AddExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ronan-The-Best Expenses App'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onDeleteExpense: _deleteExpense,
            ),
          ),
        ],
      ),
    );
  }
}
