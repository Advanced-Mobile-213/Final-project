import 'dart:io';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate user email
    bool isWindows = Platform.isWindows;
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = isWindows ? 400 : screenWidth * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context,
                '/forgot_password/verify_code'); // Navigate back to the previous screen
          },
        ),
        elevation: 0, // Optional: remove shadow
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        // Center the entire content horizontally
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: containerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
              children: [
                // Forgot Password Title
                Text(
                  'Set A New Password',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Instruction Text
                Text(
                  'Create a new password. Ensure it differs from previous ones for security',
                  style: TextStyle(color: AppColors.greyText, fontSize: 15),
                ),
                SizedBox(height: 20),

                TextInput(label: 'New password', hintText: 'Enter your new password'),
                TextInput(label: 'Confirm password', hintText: 'Confirm your password'),

                // Reset Password Button
                WideButton(
                    text: "Update Password",
                    onPressed: () {}
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
