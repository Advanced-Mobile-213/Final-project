import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/ai_bot/ai_bot_create_view.dart';
import 'package:chatbot_agents/widgets/chatbot_radius_card.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/category_button.dart';
import 'ai_bot_detail_view.dart';

class AIBotView extends StatelessWidget {
  const AIBotView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> chatbotNames = [
      "Gemini",
      "ChatGPT",
      "Bard",
      "Claude",
      "Claude-2",
      "My Agent"
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'All Bots',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    WideButton(
                      width: 60,
                      text: '+',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AiBotCreateView(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),

              // Search Bar
              SearchInput(
                onChanged: (value) {},
                hintText: "Search",
              ),
              SizedBox(height: 16),
              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryButton(
                    label: 'All',
                    onPressed: () {},
                    isActive: true,
                  ),
                  SizedBox(width: 10),
                  CategoryButton(label: 'Design', onPressed: () {}),
                  SizedBox(width: 10),
                  CategoryButton(label: 'Social', onPressed: () {}),
                  SizedBox(width: 10),
                  CategoryButton(label: 'Work', onPressed: () {}),
                ],
              ),
              SizedBox(height: 16),

              // Radius Cards for Bots
              Expanded(
                child: ListView(
                  children: List<Widget>.generate(5, (index) {
                    return ChatbotRadiusCard(
                      botName: chatbotNames[index],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AiBotDetailView(),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
    );
  }
}
