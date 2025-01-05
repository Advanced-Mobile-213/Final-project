import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class TextInput extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isRequired;
  final String? Function(String?)?
      validator; // Validator function for form validation
  final int lineNumbers;
  final int? maxLength;
  final TextInputType? keyboardType;

  const TextInput({
    super.key,
    this.label,
    this.maxLength,
    required this.hintText,
    this.obscureText = false,
    this.isRequired = false,
    this.keyboardType,
    this.onChanged,
    this.controller,
    this.validator,
    this.lineNumbers = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLength,
          maxLines: lineNumbers,
          enabled: true,
          validator: (value) {
            // If isRequired is true, ensure the field is not empty
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Please fill this field!';
            }
            // Call the passed validator if available (for additional custom validation)
            if (validator != null) {
              return validator!(value);
            }
            return null; // If valid
          },
          decoration: InputDecoration(
              label: label != null
                  ? Text(label!,
                      style: const TextStyle(fontSize: 16, color: Colors.white))
                  : null,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white30),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(15), // Add border radius here
                borderSide: const BorderSide(
                    color: Colors.grey), // Customize border color if needed
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    15), // Add border radius for enabled state
                borderSide: const BorderSide(
                    color: Colors.grey), // Customize border color if needed
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    15), // Add border radius for focused state
                borderSide: const BorderSide(
                    color: Colors.white), // Change color when focused
              ),
              counterStyle: const TextStyle(
                color: AppColors.quaternaryText,
              )),
        ),
      ],
    );
  }
}
