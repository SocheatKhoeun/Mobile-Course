import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../models/grocery_category.dart';
import '../models/mode.dart';

class NewItem extends StatefulWidget {
  const NewItem({
    super.key,
    required this.mode,
    this.existingItem, 
  });

  final Mode mode; 
  final GroceryItem? existingItem;

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;

  GroceryCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingItem?.name ?? '');
    _quantityController = TextEditingController(text: widget.existingItem?.quantity.toString() ?? '');
    _selectedCategory = widget.existingItem?.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  /// Saves the item after validation.
  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      // Show error if no category is selected.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    // Create a new GroceryItem with user input.
    final newItem = GroceryItem(
      id: widget.existingItem?.id ?? DateTime.now().toString(),
      name: _nameController.text, 
      quantity: int.parse(_quantityController.text), 
      category: _selectedCategory!,
    );

    Navigator.of(context).pop(newItem);
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _quantityController.text = ' '; 
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.mode == Mode.editing;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Item' : 'Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().length < 2 || value.trim().length > 50) {
                    return 'Must be between 2 and 50 characters.'; 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(label: Text('Quantity')),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Enter a valid quantity greater than 0.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: _selectedCategory,
                      hint: const Text('Select Category'),
                      items: GroceryCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category, 
                          child: Row(
                            children: [
                              Container(width: 16, height: 16, color: category.color),
                              const SizedBox(width: 6),
                              Text(category.label),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        _selectedCategory = value;
                      }),
                      validator: (value) => value == null ? 'Please select a category' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text(isEditing ? 'Save Changes' : 'Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
