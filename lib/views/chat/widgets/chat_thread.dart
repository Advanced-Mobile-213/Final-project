import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/chat/chat_thread_view.dart';
import 'package:flutter/material.dart';

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
          MaterialPageRoute(builder: (context) => ChatThreadView(
            conversationId: title,
          )),
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

