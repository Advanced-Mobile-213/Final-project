import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const TextInput({
    super.key,
    this.label,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          style: TextStyle(color: Colors.white),
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            label: label != null ? Text(label!, style: TextStyle(fontSize: 16, color: Colors.white),) : null,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Add border radius here
              borderSide: BorderSide(color: Colors.grey), // Customize border color if needed
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Add border radius for enabled state
              borderSide: BorderSide(color: Colors.grey), // Customize border color if needed
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Add border radius for focused state
              borderSide: BorderSide(color: Colors.white), // Change color when focused
            ),
          ),
        ),
      ],
    );
  }
}
