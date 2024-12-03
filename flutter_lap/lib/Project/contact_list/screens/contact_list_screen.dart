import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'contact_form_screen.dart';
import '../widgets/contact_card.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  void addContact(Contact contact) {
    setState(() {
      contacts.add(contact);
    });
  }

  void updateContact(String id, Contact updatedContact) {
    setState(() {
      final index = contacts.indexWhere((contact) => contact.id == id);
      if (index != -1) {
        contacts[index] = updatedContact;
      }
    });
  }

  void deleteContact(String id) {
    setState(() {
      contacts.removeWhere((contact) => contact.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Colors.blue,
      ),
      body: contacts.isEmpty
          ? Center(child: Text('No contacts yet. Add some!'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactCard(
                  contact: contact,
                  onEdit: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ContactFormScreen(
                        contact: contact,
                        onSubmit: (updatedContact) {
                          updateContact(contact.id, updatedContact);
                        },
                      ),
                    ));
                  },
                  onDelete: () {
                    deleteContact(contact.id);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ContactFormScreen(
              onSubmit: (newContact) {
                addContact(newContact);
              },
            ),
          ));
        },
      ),
    );
  }
}
