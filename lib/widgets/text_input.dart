import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const TextInput({
    super.key,
    required this.label,
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
            label: Text(label, style: TextStyle(fontSize: 16, color: Colors.white),),
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
