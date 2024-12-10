import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../data/dummy_items.dart';
import '../models/mode.dart';
import 'new_item.dart';


class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = List.from(dummyGroceryItems);
  final Set<GroceryItem> _selectedItems = {};
  Mode _currentMode = Mode.normal;

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(mode: Mode.creating),
      ),
    );

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _editItem(GroceryItem item) async {
    final editedItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItem(mode: Mode.editing, existingItem: item),
      ),
    );

    if (editedItem != null) {
      setState(() {
        final index = _groceryItems.indexWhere((element) => element.id == item.id);
        if (index != -1) {
          _groceryItems[index] = editedItem;
        }
      });
    }
  }

  void _toggleSelectionMode(GroceryItem item) {
    setState(() {
      _currentMode = Mode.selection;
      _selectedItems.add(item);
    });
  }

  void _toggleItemSelection(GroceryItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
        if (_selectedItems.isEmpty) {
          _currentMode = Mode.normal;
        }
      } else {
        _selectedItems.add(item);
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      _groceryItems.removeWhere((item) => _selectedItems.contains(item));
      _selectedItems.clear();
      _currentMode = Mode.normal;
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _selectedItems.clear();
      _currentMode = Mode.normal;
    });
  }

  // Function to handle item reordering
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _groceryItems.removeAt(oldIndex);
      _groceryItems.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_groceryItems.isNotEmpty) {
      content = ReorderableListView(
        onReorder: _onReorder, // Callback for item reordering
        children: _groceryItems.map((item) {
          final isSelected = _selectedItems.contains(item);
          return GestureDetector(
            key: Key(item.id), // Key to identify the item for reordering
            onLongPress: () => _toggleSelectionMode(item),
            child: ListTile(
              title: Text(item.name),
              leading: _currentMode == Mode.selection
                  ? Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        _toggleItemSelection(item);
                      },
                    )
                  : Container(
                      width: 24,
                      height: 24,
                      color: item.category.color,
                    ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.quantity.toString()),
                  const SizedBox(width: 10),  // Add width of 10 here
                ],
              ),
              onTap: _currentMode == Mode.selection
                  ? () => _toggleItemSelection(item)
                  : () => _editItem(item),
            ),
          );
        }).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentMode == Mode.selection
              ? '${_selectedItems.length} selected'
              : 'Your Groceries',
        ),
        leading: _currentMode == Mode.selection
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _exitSelectionMode,
              )
            : null,
        actions: _currentMode == Mode.selection
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _removeSelectedItems,
                ),
              ]
            : [
                IconButton(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                ),
              ],
      ),
      body: content,
    );
  }
}
