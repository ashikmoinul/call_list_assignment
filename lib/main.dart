import 'package:flutter/material.dart';

void main() => runApp(ContactListApp());

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Contact List',
      home: ContactListScreen(
      ),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Map<String, String>> _contacts = [];
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  void _addContact() {
    setState(() {
      _contacts.add({
        'name': _nameController.text,
        'number': _numberController.text,
      });
    });
    _nameController.clear();
    _numberController.clear();
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _contacts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addContact,
            child: Text('Add Contact'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_contacts[index]['name']!),
                  subtitle: Text(_contacts[index]['number']!),

                  onLongPress: () => _deleteContact(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
