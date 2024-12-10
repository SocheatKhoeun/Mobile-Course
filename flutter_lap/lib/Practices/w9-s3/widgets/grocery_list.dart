import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _navigateToAddItem() async {
    final newItem = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );

    if (newItem != null) {
      setState(() {
        dummyGroceryItems.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (ctx, index) {
          final item = dummyGroceryItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: item.category.color,
              child: Text(
                item.quantity.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(item.name),
            subtitle: Text(item.category.label),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _navigateToAddItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
