import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lap/Practices/w9-s1/screens/expenses/expenses_alert.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (ctx) => ExpensesAlertDialog(message: message),
    );
  }

  void onAdd() async {
    final title = _titleController.text;
    final amount = double.tryParse(_valueController.text);

    // Validate title
    if (title.isEmpty) {
      showAlert('Please enter a title');
      return;
    }

    // Validate amount
    if (amount == null || amount <= 0) {
      showAlert('Please enter a valid amount');
      return;
    }

    // Create the expense
    final expense = Expense(
      title: title,
      amount: amount,
      date: DateTime.now(), // Placeholder
      category: Category.food, // Placeholder
    );

    // Pass the expense to the parent
    widget.onCreated(expense);

    // Close modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: onAdd, child: const Text('Create')),
            ],
          )
        ],
      ),
    );
  }
}
