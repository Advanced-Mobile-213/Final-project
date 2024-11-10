import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/chat/chat_thread_view.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:flutter/material.dart';

class ChatHistoryView extends StatelessWidget {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize =
        screenHeight * 0.05; // Adjust icon size based on screen height

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic, // Ensures proper alignment
                  children: [
                    Text(
                      'Chat History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 5), // Space between title and number of threads
                    Text(
                      '(2)',  // Number of chat threads
                      style: TextStyle(
                        color: Colors.grey[400], // Lighter text for the count
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ),



              // Search Bar
              SearchInput(onChanged: (value) {}),
              const SizedBox(height: 16),

              // Chat Threads
              Expanded(
                child: ListView(
                  children: [
                    ChatThread(
                      botNames: ["ChatGPT", "Gemini"],
                      title: 'Hello',
                      time: 'a few seconds ago',
                      lastMessage:
                          'You can call me Assistant. How can I help you?',
                    ),
                    ChatThread(
                      botNames: ["Claude", "My Agent"],
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
    );
  }

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
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
          ],
        );
      },
    );
  }
}

class ChatThread extends StatelessWidget {
  final String title;
  final String time;
  final String lastMessage;
  final List<String> botNames; // List to hold bot names
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ChatThread({
    Key? key,
    required this.title,
    required this.time,
    required this.lastMessage,
    required this.botNames, // Make this required
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatThreadView()),
        );
      },
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
                    const SizedBox(height: 4),
                    // Display bot names
                    Text(
                      'Bots: ${botNames.join(', ')}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {_showEditDialog(context); }
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed:  () {
                        _showDeleteConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the Edit Dialog
  void _showEditDialog(BuildContext context) {
    TextEditingController editController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text('Edit title', style: TextStyle(color: Colors.white),),
          content: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter new chat thread title',
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () {
                String newValue = editController.text;
                if (newValue.isNotEmpty) {
                  // Handle edit action here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New title edited: $newValue')),
                  );
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save',style: TextStyle(color: Colors.white), ),
            ),
          ],
        );
      },
    );
  }

  // Method to show the Delete Confirmation Dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text('Delete Item', style: TextStyle(color: Colors.white),),
          content: const Text('Are you sure you want to delete this thread chat?', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel' , style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () {
                // Handle delete action here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item deleted')),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

}

