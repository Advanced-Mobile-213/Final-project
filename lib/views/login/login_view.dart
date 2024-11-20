import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_tab.dart';
import '../../provider/auth_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/validator_utils.dart';
import '../../widgets/text_input.dart';
import '../../widgets/wide_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}



class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'tien.hcmus.569@gmail.com');
  final passwordController = TextEditingController(text: 'Adv@ncedMobile213');
  bool isPasswordHidden = true;
  bool isLoading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          _buildForm(context),
          if (isLoading) _buildLoadingIndicator(), // Overlay loading indicator
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWindows = Platform.isWindows;
              double containerWidth = isWindows ? 400 : double.infinity;
              return Center(
                child: SizedBox(
                  width: containerWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        TextInput(
                          label: "Password",
                          hintText: "Enter password",
                          controller: passwordController,
                          obscureText: isPasswordHidden, onChanged: (String ) {  },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: WideButton(
                            text: 'SIGN IN',
                            onPressed: isLoading
                                ? null // Disable button while loading
                                : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await _handleLogin(context);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
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

  // Build the loading indicator
  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black.withOpacity(0.5), // Semi-transparent background
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    setState(() {
      isLoading = true; // Show loading
    });

    final authProvider = context.read<AuthProvider>();
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final errorResponse = await authProvider.login(email, password);
      if (!context.mounted) return;

      // Hide the loading indicator if the dialog is displayed
      setState(() {
        isLoading = false;
      });

      if (errorResponse != null) {
        _showErrorDialog(context, errorResponse);
      } else {
        Navigator.pushNamed(context, "/main", arguments: {'selectedTab': AppTab.chat});
      }
    } catch (e) {
      // Handle unexpected errors and hide loading if necessary
      if (!context.mounted) return;
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(context, 'An unexpected error occurred.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text('Error', style: TextStyle(color: Colors.white)),
          content: Text(message, style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
