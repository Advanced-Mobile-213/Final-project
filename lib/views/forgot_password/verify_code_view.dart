import 'dart:io';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

import '../../widgets/text_input.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate user email
    String email = "example@gmail.com";
    bool isWindows = Platform.isWindows;
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = isWindows ? 400 : screenWidth * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context,
                '/forgot_password/enter_email'); // Navigate back to the previous screen
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the left
              children: [
                // Forgot Password Title
                Text(
                  'Check Your Email',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Instruction Text
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.greyText), // Default style for all
                    children: [
                      TextSpan(text: 'We sent a reset link to '),
                      TextSpan(
                        text: email,
                        style: TextStyle(color: AppColors.tertiaryText, fontWeight: FontWeight.bold), // Email color
                      ),
                      TextSpan(
                          text:
                              ', enter 5 digit code that mentioned in the email'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Email Label

                // Code Input
                TextInput(label: "Code", hintText: 'Enter you code (only 5 digits)', onChanged: (value){}),


                // Reset Password Button
                WideButton(
                    text: "Verify Code",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, "/forgot_password/update_password");
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
