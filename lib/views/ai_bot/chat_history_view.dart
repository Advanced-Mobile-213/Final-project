import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:flutter/material.dart';
import '../../constants/app_icons.dart';

class ChatHistoryView extends StatelessWidget {
  const ChatHistoryView({super.key});

  void _createNewThreadDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text(
            'New Chat Thread Title',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: TextField(
              style: TextStyle(color: Colors.white),
              controller: titleController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter chat thread title',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Add border radius here
                  borderSide: BorderSide(
                      color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Add border radius for focused state
                  borderSide: BorderSide(
                      color: Colors.white), // Change color when focused
                ),
              )),
          actions: [
            TextButton(
              onPressed: () {
                final String newThreadTitle = titleController.text;
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize =
        screenHeight * 0.05; // Adjust icon size based on screen height

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryBackground,
        title: Text(
          'Gemini',
          style: TextStyle(
              color: Colors.white, fontSize: 24), // Responsive text size
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Chat History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Search Bar
              SearchInput(onChanged: (value) {}),
              const SizedBox(height: 16),

              // Chat Threads
              Expanded(
                child: ListView(
                  children: [
                    ChatThread(
                      title: 'Hello',
                      time: 'a few seconds ago',
                      lastMessage:
                          'You can call me Assistant. How can I help you?',
                    ),
                    ChatThread(
                      title: 'AI Service',
                      time: '7 minutes ago',
                      lastMessage: 'Side offers All-in-One AI Service',
                    ),
                    // Add more ChatThreads as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      // Floating Action Button to create new chat thread
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewThreadDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: AppColors.secondaryBackground,
      ),
      // Footer (Optional)
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: Text(
              'Footer Content Here',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white), // Ensure footer text is visible
            ),
          ),
        ),
      ),
    );
  }
}

class ChatThread extends StatelessWidget {
  final String title;
  final String time;
  final String lastMessage;

  const ChatThread({
    super.key,
    required this.title,
    required this.time,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){ Navigator.pushNamed(context, '/ai_bot/chats/thread'); },
        child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lastMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit action
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Handle delete action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
