import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
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

  // List of bots
  final List<String> bots = ['ChatGPT 4.0', 'Gemini', 'Claude'];
  String selectedBot = 'ChatGPT 4.0'; // Default bot

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pops the current screen from the navigation stack
          },
        ),
        centerTitle: true,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(
        //       Icons.android, // Chatbot icon
        //       color: Colors.white,
        //     ),
        //     SizedBox(width: 8),
        //     Text(
        //       selectedBot, // Display selected bot name
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ],
        // ),
        backgroundColor: AppColors.primaryBackground,
        actions: [
          // Dropdown button to select bot
          DropdownButton<String>(
            value: selectedBot,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: AppColors.secondaryBackground,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                selectedBot = newValue!;
              });
            },
            items: bots.map<DropdownMenuItem<String>>((String bot) {
              return DropdownMenuItem<String>(
                value: bot,
                child: Text(bot, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
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
                  flex: 4,
                  child: TextInput(
                    hintText: "Enter message",
                    controller: _controller,
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),)

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

        // Simulate chatbot reply based on selected bot
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            messages.insert(0, {
              'content': '[$selectedBot] This is a reply to: ${_controller.text}',
              'isUserMessage': false,
            });
          });
        });
      });

      // Clear the input field
      _controller.clear();
    }
  }
}
