import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lap/W7-S2/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void onAdd() {
    // Get the values from inputs
    String title = _titleController.text;
    double? amount = double.tryParse(_valueController.text);

    // Validate inputs
    if (title.isEmpty || amount == null || _selectedCategory == null || _selectedDate == null) {
      return; // Optionally, show a validation error to the user
    }

    // Create the expense
    Expense expense = Expense(
      title: title,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    // Ask the parent to add the expense
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
            controller: _valueController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allow numbers with decimals
            ],
            maxLength: 10,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            hint: const Text('Select Category'),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : 'Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _selectDate,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: onAdd, child: const Text('Create')),
            ],
          ),
        ],
      ),
    );
  }
}
