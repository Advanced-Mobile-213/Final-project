// Radius Card Widget
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ChatbotRadiusCard extends StatelessWidget {
  final String botName;
  final VoidCallback onPressed;

  const ChatbotRadiusCard({Key? key, required this.botName, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // This will trigger the onPressed function when tapped
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
            children: [
              Icon(
                Icons.android, // Replace with your preferred icon
                color: Colors.white, // Icon color
                size: 24, // Adjust the size as needed
              ),
              SizedBox(width: 10), // Adds some space between the icon and text
              Text(
                botName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}