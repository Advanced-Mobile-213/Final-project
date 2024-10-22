import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const TextInput({
    Key? key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
