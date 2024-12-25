import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';

class HistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> deletedNotes;
  final void Function(Note note, int index) onRecoverNote; 

  const HistoryScreen({
    super.key,
    required this.deletedNotes,
    required this.onRecoverNote,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> localDeletedNotes;

  @override
  void initState() {
    super.initState();
    localDeletedNotes = List.from(widget.deletedNotes);
  }

  void _recoverNote(Map<String, dynamic> deletedNote, int index) {
    final note = deletedNote['note'] as Note; 
    final originalIndex = deletedNote['index'] as int;

    widget.onRecoverNote(note, originalIndex); 

    setState(() {
      localDeletedNotes.removeAt(index);  
    });
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
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromARGB(255, 239, 222, 33),
                  ),
                ),
                const Text(
                  'History',
                  style: TextStyle(fontSize: 30, color: Color(0xFFFFD700)),
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
              child: localDeletedNotes.isNotEmpty
                  ? ListView.builder(
                      itemCount: localDeletedNotes.length,
                      itemBuilder: (context, index) {
                        final deletedNote = localDeletedNotes[index];
                        final note = deletedNote['note'] as Note;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: const Color.fromARGB(255, 87, 86, 86),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey.shade800,
                                    title: Text(
                                      note.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Type: ${note.category.name}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          note.content,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Date: ${DateFormat('EEE MMM d, yyyy h:mm a').format(note.modifiedTime)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _recoverNote(deletedNote, index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Recover',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
                              'Date: ${DateFormat('EEE MMM d, yyyy h:mm a').format(note.modifiedTime)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No deleted notes.',
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

