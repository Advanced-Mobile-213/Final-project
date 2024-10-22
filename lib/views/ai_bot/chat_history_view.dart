import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:flutter/material.dart';

import '../../widgets/category_button.dart';

class ChatHistoryView extends StatelessWidget {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('AI Bots'),
        backgroundColor: AppColors.tertiaryBackground.withOpacity(0.8),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Chat History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Search Bar
              SearchInput(onChanged: (value) {}),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      // Footer (Optional)
      bottomNavigationBar: BottomAppBar(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              /* For testing */
              onTap: () { Navigator.pushReplacementNamed(context, "/login");} ,
              child: Text(
                'Footer Content Here',
                textAlign: TextAlign.center,
              ),
            )
        ),
      ),
    );
  }
}