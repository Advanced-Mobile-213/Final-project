import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Check if it's a large screen
                bool isWindows =  Platform.isWindows;
                double screenWidth = MediaQuery.of(context).size.width;
                double containerWidth = isWindows
                    ? 400 // Fixed width on Windows
                    : screenWidth * 0.8; // 60% of screen width on mobile

                return Center(
                  child: Container(
                    width: containerWidth, // Limit width on large screens
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Sign in Title
                        Text(
                          'Sign in your account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isWindows ? 28 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),// Email Label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Email Input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'example@email.com',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Password Label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Password Input
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'password',
                            border: OutlineInputBorder(),
                          ),
                        ),


                        SizedBox(height: 20),

                        // Sign in Button
                        SizedBox(
                          width: double.infinity, // Button fills the width
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('SIGN IN', style: TextStyle( color: Colors.black),),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Forgotten password
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgotten password?', style: TextStyle(color: Colors.white),),
                        ),

                        // or sign in with
                        Text('or sign in with'),
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
                            Text("Don't have an account?", style: TextStyle(color: Colors.white),),
                            TextButton(
                              onPressed: () {},
                              child: Text('SIGN UP', style: TextStyle(color: AppColors.tertiaryText),),
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
      ),
    );
  }
}
