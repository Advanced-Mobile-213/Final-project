import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class ChatThreadView extends StatefulWidget {
  const ChatThreadView({super.key});

  @override
  _ChatThreadViewState createState() => _ChatThreadViewState();
}

class _ChatThreadViewState extends State<ChatThreadView> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {'content': 'Hello! How can I assist you today?', 'isUserMessage': false},
    {'content': 'What can you do?', 'isUserMessage': true},
    {'content': 'I can help with many things like answering questions and more.', 'isUserMessage': false},
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pops the current screen from the navigation stack
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.android, // Chatbot icon
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Gemini', // Chatbot name
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
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['isUserMessage'];

                return isUserMessage
                    ? _buildMeReply(message, screenWidth)
                    : _buildChatbotReply(message, screenWidth);
              },
            ),
          ),

          // Input field to send new message
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextInput(hintText: "Enter message", onChanged: (value){})
                ),
                SizedBox(width: screenWidth * 0.02),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
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

  Widget _buildChatbotReply(Map<String, dynamic> message, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chatbot Icon
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.android, color: Colors.white),
        ),
        SizedBox(width: screenWidth * 0.02),

        // Chatbot Message
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(screenWidth * 0.04),
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

  Widget _buildMeReply(Map<String, dynamic> message, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // User Message
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            message['content'],
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
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
