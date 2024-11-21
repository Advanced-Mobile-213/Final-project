import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ChatbotRadiusCard extends StatelessWidget {
  final String botNames;
  final String imageUrl;
  final VoidCallback onPressed;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ChatbotRadiusCard({
    super.key,
    required this.botNames,
    required this.imageUrl,
    required this.onPressed,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(bottom: 16, top: 8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display bot image and name
              Row(
                children: [
                  Image.network(
                    imageUrl,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    botNames,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Edit and Delete buttons
              Row(
                children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: (){_showDeleteConfirmationDialog(context);},
                    ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the Delete Confirmation Dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text('Delete Chatbot', style: TextStyle(color: Colors.white),),
          content: const Text('Are you sure you want to delete this chatbot?', style: TextStyle(color: Colors.white),),
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
