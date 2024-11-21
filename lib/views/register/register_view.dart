import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:chatbot_agents/utils/validator_utils.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  bool isPasswordHidden = true; // To toggle visibility of password fields
  bool isConfirmPasswordHidden = true;
  bool isLoading = false; // To track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Fill at least the screen height
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWindows = Platform.isWindows;
                  double containerWidth = isWindows ? 400 : double.infinity;

                  return SizedBox(
                    width: containerWidth, // Limit width for larger screens
                    child: Form(
                      key: _formKey, // Form key for validation
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'Create your account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isWindows ? 28 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // Username input
                          TextInput(
                            label: "Username",
                            hintText: "Enter your username",
                            controller: usernameController,
                            isRequired: true,
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),

                          // Email input with validation
                          TextInput(
                            label: "Email",
                            hintText: "Enter your email",
                            controller: emailController,
                            isRequired: true,
                            onChanged: (value) {},
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

                          // Password input
                          TextInput(
                            label: "Password",
                            hintText: "Enter your password",
                            controller: passwordController,
                            obscureText: isPasswordHidden,
                            isRequired: true,
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),

                          // Confirm Password input
                          TextInput(
                            label: "Confirm Password",
                            hintText: "Confirm your password",
                            controller: confirmPasswordController,
                            obscureText: isConfirmPasswordHidden,
                            isRequired: true,
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),

                          // Sign up button or loader
                          isLoading
                              ? const CircularProgressIndicator() // Show loader
                              : SizedBox(
                            width: double.infinity,
                            child: WideButton(
                              text: 'SIGN UP',
                              onPressed: () async {
                                await _handleRegister(context);
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'or sign in with',
                            style: TextStyle(color: AppColors.tertiaryText),
                          ),
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

                          // Login prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(color: AppColors.tertiaryText),
                                ),
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
      ),
    );
  }

  // Method to handle sign-up logic
  Future<void> _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      _showDialog(
        context,
        "Password Mismatch",
        "Your confirm password does not match. Please try again.",
      );
      return;
    }

    setState(() {
      isLoading = true; // Start loading
    });

    final authProvider = context.read<AuthProvider>();
    final errorResponse = await authProvider.register(
      emailController.text,
      passwordController.text,
      usernameController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false; // Stop loading
    });

    if (errorResponse != null && errorResponse.isNotEmpty) {
      _showDialog(context, "Error", errorResponse);
    } else {
      _showDialog(
        context,
        "Account Created",
        "Please check your email to activate your account.",
      );
    }
  }

  // Method to show a dialog with a message
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
