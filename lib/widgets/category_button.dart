import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isActive; // Add isActive flag

  const CategoryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isActive = false, // Default isActive to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive
            ? Colors.white
            : Colors.grey, // Black when active, gray when not
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isActive ? Colors.black : Colors.black.withOpacity(0.5),
            fontWeight:
                FontWeight.w800 // White text when active, black text otherwise
            ),
      ),
    );
  }
}
