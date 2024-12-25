import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import 'note_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Note> filteredNotes;
  NoteCategory? selectedCategory;
  List<Map<String, dynamic>> deletedNotes = [];

  @override
  void initState() {
    super.initState();
    filteredNotes = List.from(sampleNotes);
  }

  void _resetNotes() {
    setState(() {
      filteredNotes = List.from(sampleNotes);
      selectedCategory = null;
    });
  }

  void _filterNotes(String query) {
    setState(() {
      _resetNotes();
      filteredNotes = sampleNotes
          .where((note) =>
              (selectedCategory == null || note.category == selectedCategory) &&
              (note.title.toLowerCase().contains(query.toLowerCase()) ||
                  note.content.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _updateCategory(NoteCategory? category) {
    setState(() {
      filteredNotes = category == null
          ? List.from(sampleNotes)
          : sampleNotes.where((note) => note.category == category).toList();
      selectedCategory = category;
    });
  }

  void _deleteNote(Note note, int index) {
    setState(() {
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
      deletedNotes.add({'note': note, 'index': index});
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              final deletedNote = deletedNotes.last;
              deletedNotes.removeLast();
              sampleNotes.insert(deletedNote['index'], deletedNote['note']);
              filteredNotes = List.from(sampleNotes);
            });
          },
        ),
      ),
    );
  }

  void _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NoteScreen()),
    );
    if (result != null) {
      setState(() {
        sampleNotes.add(result);
        filteredNotes.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 30, color: Color(0xFFFFD700)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoryScreen(
                          deletedNotes: deletedNotes,
                          onRecoverNote: (note, index) {
                            setState(() {
                              deletedNotes.removeWhere((element) => element['note'].id == note.id);
                              sampleNotes.insert(index, note);
                              filteredNotes = List.from(sampleNotes);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.history,
                    color: Color.fromARGB(255, 239, 222, 33),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: _addNote,
                  icon: const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 239, 222, 33),
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _filterNotes,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search notes...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      fillColor: Colors.grey.shade800,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme:
                        PopupMenuThemeData(color: Colors.grey.shade800),
                  ),
                  child: PopupMenuButton<NoteCategory?>(
                    icon: Icon(
                      Icons.menu_book,
                      color: selectedCategory == null
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
                  onPressed: _resetNotes,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 198, 43),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  ),
                  child: const Text(
                    'All Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'List Notes',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 138, 137, 136),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredNotes.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        return Dismissible(
                          key: ValueKey(note.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                          onDismissed: (_) {
                            _deleteNote(note, index);
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            color: const Color.fromARGB(255, 87, 86, 86),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Type: ${note.category.name}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'Modify: ${DateFormat('EEE MMM d, yyyy h:mm a').format(note.modifiedTime)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NoteScreen(note: note),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    final index =
                                        sampleNotes.indexOf(note);
                                    sampleNotes[index] = result;
                                    filteredNotes = List.from(sampleNotes);
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No notes found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
