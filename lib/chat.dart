import 'dart:convert'; // Import dart:convert for jsonDecode
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String user;
  final String recipient;

  ChatPage({required this.user, required this.recipient});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = []; // List to hold chat messages

  @override
  void initState() {
    super.initState();
    _loadChatMessages(); // Load chat messages from shared preferences when the widget initializes
  }

  void _loadChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '${widget.user}_${widget.recipient}'; // Unique key for chat between user and recipient
    List<String>? messagesJson = prefs.getStringList(key);

    if (messagesJson != null) {
      setState(() {
        _messages = messagesJson.map((messageJson) => jsonDecode(messageJson) as Map<String, dynamic>).toList();
      });
    }
  }

  void _saveChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '${widget.user}_${widget.recipient}'; // Unique key for chat between user and recipient

    List<String> messagesJson = _messages.map((message) => jsonEncode(message)).toList(); // Encode Map to JSON string
    prefs.setStringList(key, messagesJson);
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    // Add message to local list
    _messages.add({
      'text': text,
      'sender': widget.user,
      'time': DateTime.now().toIso8601String(),
    });

    // Save messages to shared preferences
    _saveChatMessages();

    // Clear text input after sending message
    _controller.clear();

    // Force the UI to rebuild to show the new message
    setState(() {});

    // Optional: Simulate a reply from recipient after a delay
    Future.delayed(Duration(seconds: 1), () {
      _receiveMessage();
    });
  }

  void _receiveMessage() {
    // Simulating a reply from recipient
    _messages.add({
      'text': 'Hello ${widget.user}, how can I help you?',
      'sender': widget.recipient,
      'time': DateTime.now().toIso8601String(),
    });

    // Save messages to shared preferences
    _saveChatMessages();

    // Force the UI to rebuild to show the received message
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.recipient}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == widget.user;

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              fontSize: 16.0,
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${message['sender']} • ${DateTime.parse(message['time']).hour}:${DateTime.parse(message['time']).minute}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: isUser ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
