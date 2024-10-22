import 'dart:io';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class EnterEmailView extends StatelessWidget {
  const EnterEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWindows = Platform.isWindows;
    double containerWidth = isWindows ? 400 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/login'); // Navigate back to the previous screen
          },
        ),
        elevation: 0, // Optional: remove shadow
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Center( // Center the entire content horizontally
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: containerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
              children: [
                // Forgot Password Title
                Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Instruction Text
                Text(
                  'Please enter your email to reset the password',
                  style: TextStyle(color: AppColors.greyText, fontSize: 15),
                ),
                SizedBox(height: 20),
                // Email Input
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Reset Password Button
                WideButton(text: "Reset Password", onPressed: () { Navigator.pushReplacementNamed(context, "/forgot_password/verify_code");})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
