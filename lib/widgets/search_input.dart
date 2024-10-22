import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged; // Callback when the text changes

  const SearchInput({
    Key? key,
    this.hintText = 'Search', // Default hint text
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged, // Call the callback when text changes
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
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
        prefixIcon: Icon(Icons.search, color: Colors.white,),
      ),
    );
  }
}
