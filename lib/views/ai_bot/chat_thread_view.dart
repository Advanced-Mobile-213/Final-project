import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class ChatThreadView extends StatefulWidget {
  const ChatThreadView({super.key});

  @override
  _ChatThreadViewState createState() => _ChatThreadViewState();
}

class _ChatThreadViewState extends State<ChatThreadView> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.android, // Chatbot icon
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Chatbot', // Chatbot name
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryBackground,
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['isUserMessage'];

                return isUserMessage ? _buildMeReply(message) : _buildChatbotReply(message);
              },
            ),
          ),

          // Input field to send new message
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
    );
  }

  Widget _buildChatbotReply(Map<String, dynamic> message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chatbot Icon
        CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.android, color: Colors.white),
        ),
        SizedBox(width: 10),

        // Chatbot Message
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message['content'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeReply(Map<String, dynamic> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // User Message
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            message['content'],
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Add user message
        messages.insert(0, {'content': _controller.text, 'isUserMessage': true});

        // Simulate chatbot reply
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            messages.insert(0, {
              'content': 'This is a chatbot reply to: ${_controller.text}',
              'isUserMessage': false
            });
          });
        });
      });

      // Clear the input field
      _controller.clear();
    }
  }
}
