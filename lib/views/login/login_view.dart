import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_tab.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});


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
                          'Sign in your account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isWindows ? 28 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),// Email Label
                        TextInput(label: "Email", hintText: "Enter email", onChanged: (value) {},),
                        SizedBox(height: 20),
                        TextInput(label: "Password", hintText: "Enter password", onChanged: (value) {},),
                        SizedBox(height: 20),
                        // Sign in Button
                        SizedBox(
                          width: double.infinity, // Button fills the width
                          child: WideButton(
                            text: 'SIGN IN',
                            onPressed: (){
                              Navigator.pushNamed(
                                context, 
                                "/main",
                                arguments: {'selectedTab': AppTab.chat}
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        // Forgotten password
                        TextButton(
                          onPressed: () { Navigator.pushNamed(context, "/forgot_password/enter_email"); },
                          child: Text('Forgotten password?', style: TextStyle(color: Colors.white),),
                        ),

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
                                child: Image.memory(AppUtils.bytesFromBase64String(AppIcons.GoogleBase64ImageString)),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: SizedBox(
                                width: isWindows ? 50 : 40, // Adjust icon size for larger screens
                                height: isWindows ? 50 : 40,
                                child: Image.memory(AppUtils.bytesFromBase64String(AppIcons.FacebookBase64ImageString)),
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
                              onPressed: () { Navigator.pushNamed(context, "/register"); },
                              child: Text('REGISTER', style: TextStyle(color: AppColors.tertiaryText),),
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
