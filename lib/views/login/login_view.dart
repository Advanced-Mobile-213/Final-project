import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/utils/app_utils.dart';
import 'package:chatbot_agents/utils/validator_utils.dart';
import 'package:chatbot_agents/widgets/app_logo.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add provider for managing authentication

import '../../constants/app_icons.dart';
import '../../constants/app_tab.dart';
import '../../provider/auth_provider.dart'; // Ensure you have this provider

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'tien.hcmus.569@gmail.com');//tien123@gmail.com
  //hoangquoc2106@gmail.com
  // final emailController = TextEditingController();
  final passwordController = TextEditingController(text: 'Adv@ncedMobile213');//Adv@ncedMobile213
  // final passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool _isLoading = false; // Loading state


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensures content fills the screen height
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWindows = Platform.isWindows;
                  double containerWidth = isWindows ? 400 : double.infinity;

                  return SizedBox(
                    width: containerWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the children
                        crossAxisAlignment: CrossAxisAlignment.center, // Horizontally centers the children
                        children: [
                          AppLogo(width: isWindows ? 50 : 40, height: isWindows ? 50 : 40,),
                          const SizedBox(height: 20),
                          // Title
                          Text(
                            'Sign in your account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isWindows ? 28 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // Email Input
                          TextInput(
                            label: "Email",
                            hintText: "Enter email",
                            controller: emailController,
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

                          // Password Input
                          TextInput(
                            label: "Password",
                            hintText: "Enter password",
                            controller: passwordController,
                            obscureText: isPasswordHidden,
                          ),
                          const SizedBox(height: 20),

                          // Sign-in Button or Loader
                          _isLoading
                              ? const CircularProgressIndicator() // Loader while logging in
                              : SizedBox(
                            width: double.infinity,
                            child: WideButton(
                              text: 'SIGN IN',
                              onPressed: () async {
                                await _handleLogin(context);
                              },
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Forgotten Password
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/forgot_password/enter_email");
                            },
                            child: const Text(
                              'Forgotten password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Alternative Sign-in Text
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
                                  width: isWindows ? 50 : 40,
                                  height: isWindows ? 50 : 40,
                                  child: Image.memory(
                                    AppUtils.bytesFromBase64String(AppIcons.GoogleBase64ImageString),
                                  ),
                                ),
                                onPressed: () {},
                              ),

                            ],
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/register");
                                },
                                child: const Text(
                                  'REGISTER',
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

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true); // Start loading
      print(_isLoading);
      final email = emailController.text;
      final password = passwordController.text;

      final authProvider = context.read<AuthProvider>();
      final errorResponse = await authProvider.login(email, password);

      if (!context.mounted) return; // Prevent further actions if widget is not mounted

      setState(() => _isLoading = false); // Stop loading

      if (errorResponse != null) {
        _showDialog(context, errorResponse);
      } else {
        Navigator.pushNamed(
          context,
          "/main",
          arguments: {'selectedTab': AppTab.chat},
        );
      }
    }
  }

  void _showDialog(BuildContext context, String message) {
    if (!context.mounted) return;

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
