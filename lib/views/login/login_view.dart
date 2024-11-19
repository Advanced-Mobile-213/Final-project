import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:chatbot_agents/utils/validator_utils.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Add provider for managing authentication

import '../../constants/app_icons.dart';
import '../../constants/app_tab.dart';
import '../../provider/auth_provider.dart'; // Ensure you have this provider

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Create a GlobalKey for the form validation
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'hoangquoc2106@gmail.com');
  final passwordController = TextEditingController(text: 'Adv@ncedMobile213');
  bool isPasswordHidden = true; // Toggle visibility of password field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if it's a large screen
              bool isWindows = Platform.isWindows;
              double containerWidth = isWindows ? 400 : double.infinity;
              return Center(
                child: SizedBox(
                  width: containerWidth, // Limit width on large screens
                  child: Form(
                    key: _formKey, // Attach the GlobalKey to the form
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
                        const SizedBox(height: 20), // Email Label
                        TextInput(
                          label: "Email",
                          hintText: "Enter email",
                          controller: emailController,
                          onChanged: (value) {},
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!ValidatorUtils.isValidEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextInput(
                          label: "Password",
                          hintText: "Enter password",
                          controller: passwordController,
                          obscureText: isPasswordHidden,
                          onChanged: (value) {},
                          isRequired: true,
                        ),
                        const SizedBox(height: 20),
                        // Sign in Button
                        SizedBox(
                          width: double.infinity, // Button fills the width
                          child: WideButton(
                            text: 'SIGN IN',
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final email = emailController.text;
                                final password = passwordController.text;

                                final authProvider = context.read<AuthProvider>();
                                final errorResponse = await authProvider.login(email, password);
                                if (!context.mounted) return;
                                if (errorResponse != null) {
                                  _showErrorDialog(context, errorResponse);
                                } else {
                                  // On success, navigate to the main screen
                                  Navigator.pushNamed(
                                    context,
                                    "/main",
                                    arguments: {'selectedTab': AppTab.chat},
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Forgotten password
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/forgot_password/enter_email");
                          },
                          child: const Text(
                            'Forgotten password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        // or sign in with
                        const Text('or sign in with', style: TextStyle(color: AppColors.tertiaryText)),
                        const SizedBox(height: 10),

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
                            const SizedBox(width: 20),
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
                        const SizedBox(height: 20),

                        // Sign up prompt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?", style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/register");
                              },
                              child: const Text('REGISTER', style: TextStyle(color: AppColors.tertiaryText)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Function to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
