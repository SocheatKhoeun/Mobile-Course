import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;
  const NoteScreen({super.key, this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  NoteCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedCategory = widget.note?.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  void _saveNotes() {
    if (_titleController.text.trim().isEmpty || _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    if (_selectedCategory == null) {
      _showCategoryDialog();
      return;
    }

    Navigator.pop(
      context,
      Note(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory!,
        modifiedTime: DateTime.now(),
      ),
    );
  }

  void _showCategoryDialog() {
    NoteCategory? tempSelectedCategory = _selectedCategory;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[850],
              title: const Text(
                'Select Note Type',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: NoteCategory.values.map((category) {
                  return RadioListTile<NoteCategory>(
                    title: Text(
                      category.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: category,
                    groupValue: tempSelectedCategory,
                    onChanged: (NoteCategory? value) {
                      setState(() {
                        tempSelectedCategory = value;
                      });
                    },
                    activeColor: Colors.white,
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (tempSelectedCategory != null) {
                      setState(() {
                        _selectedCategory = tempSelectedCategory;
                      });
                      Navigator.pop(context);
                      _saveNotes();
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateCategory(NoteCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 30, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color.fromARGB(255, 239, 222, 33),
                      ),
                    ),
                    const Text(
                      'Back',
                      style: TextStyle(fontSize: 30, color: Color(0xFFFFD700)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: PopupMenuThemeData(color: Colors.grey.shade800),
                      ),
                      child: PopupMenuButton<NoteCategory?>(
                        icon: Icon(
                          Icons.menu,
                          color: _selectedCategory == null
                              ? const Color(0xFFFFD700)
                              : Colors.grey.shade700,
                        ),
                        onSelected: _updateCategory,
                        itemBuilder: (context) {
                          return NoteCategory.values
                              .map((category) => PopupMenuItem<NoteCategory?>(
                                    value: category,
                                    child: Text(
                                      category.name,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList();
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: _saveNotes,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 225, 198, 43),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20), 
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _contentController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something here',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
