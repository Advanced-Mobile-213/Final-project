import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';

class Screen extends StatelessWidget {
  final List<Widget> children;

  const Screen({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
                .map((child) => Padding(
                    padding: EdgeInsets.only(bottom: spacing[2]), child: child))
                .toList(),
          ),
        ),
      ),
    );
  }
}
