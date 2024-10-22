import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icons.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if it's a large screen
              bool isWindows =  Platform.isWindows;
              double containerWidth = isWindows ? 400 : double.infinity;
              return Center(
                child: Container(
                  width: containerWidth, // Limit width on large screens
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sign in Title
                      Text(
                        'Create your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isWindows ? 28 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      TextInput(label: "Name", hintText: "Enter your name", onChanged: (value) {},),
                      TextInput(label: "Email", hintText: "Enter your email", onChanged: (value) {},),
                      TextInput(label: "Password", hintText: "Enter your password", onChanged: (value) {},),
                      // Sign in Button
                      SizedBox(
                          width: double.infinity, // Button fills the width
                          child: WideButton(text: 'SIGN UP', onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.primaryBackground,
                                  title: Text('Account Created', style: TextStyle(color: Colors.white),),
                                  content: Text('Please check your email to activate your account.', style: TextStyle(color: Colors.white),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: Text('OK', style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                );
                              },
                            );

                          })
                      ),
                      SizedBox(height: 10),
                      // or sign in with
                      Text('or sign in with', style: TextStyle(color: AppColors.tertiaryText),),
                      SizedBox(height: 10),

                      // Social Media Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SizedBox(
                              width: isWindows ? 50 : 40, // Adjust icon size for larger screens
                              height: isWindows ? 50 : 40,
                              child: Image.memory(AppUtils.bytesFromBase64String(AppIcons.GOOGLE_BASE64_IMAGE_STRING)),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            icon: SizedBox(
                              width: isWindows ? 50 : 40, // Adjust icon size for larger screens
                              height: isWindows ? 50 : 40,
                              child: Image.memory(AppUtils.bytesFromBase64String(AppIcons.FACEBOOK_BASE64_IMAGE_STRING)),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Sign up prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?", style: TextStyle(color: Colors.white),),
                          TextButton(
                            onPressed: () { Navigator.pushNamed(context, "/login"); },
                            child: Text('LOGIN', style: TextStyle(color: AppColors.tertiaryText),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
