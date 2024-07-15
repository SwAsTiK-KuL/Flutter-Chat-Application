import 'package:flutter/material.dart';
import 'chat.dart'; // Import your ChatPage widget

class MembersListPage extends StatelessWidget {
  final String user;
  final List<String> members = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Hannah',
    'Isaac',
    'Jack',
    'Katie',
    'Liam',
    'Mia',
    'Noah',
    'Olivia',
    'Paul',
    'Quinn',
    'Ryan',
    'Sarah',
    'Tom'
  ]; // List of random member names

  MembersListPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  members[index][0].toUpperCase(),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              title: Text(
                members[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Member since ${DateTime.now().year - index}',
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to ChatPage with selected member
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(user: user, recipient: members[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
