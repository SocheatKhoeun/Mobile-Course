import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const AddExpense({super.key, required this.onAddExpense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseType _selectedCategory = ExpenseType.FOOD;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;

    final newExpense = Expense(
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<ExpenseType>(
            value: _selectedCategory,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
              }
            },
            items: ExpenseType.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitData,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
