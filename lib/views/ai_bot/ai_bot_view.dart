import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/chatbot_radius_card.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:flutter/material.dart';

import '../../widgets/category_button.dart';

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
    List<String> chatbotNames = ["Gemini", "ChatGPT", "Bard", "Claude", "Claude-2"];
    List<String> chatbotIcons = [AppIcons.GeminiImageBotUrl, AppIcons.ChatGPTImageUrl, AppIcons.BardImageUrl, AppIcons.ClaudeImageUrl, AppIcons.Claude2ImageUrl];

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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryButton(label: 'All', onPressed: (){}, isActive: true,),
                    SizedBox(width: 10),
                    CategoryButton(label: 'Design', onPressed: (){}),
                    SizedBox(width: 10),
                    CategoryButton(label: 'Social', onPressed: (){}),
                    SizedBox(width: 10),
                    CategoryButton(label: 'Work', onPressed: (){}),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Radius Cards for Bots
              Expanded(
                child: ListView(
                  children: List<Widget>.generate(5, (index) {
                    return ChatbotRadiusCard(botName: chatbotNames[index], imageUrl: chatbotIcons[index] , onPressed: (){ Navigator.pushNamed(context, "/ai_bot/chats");},);
                    return ChatbotRadiusCard(
                      botName: chatbotNames[index],
                      imageUrl: chatbotIcons[index],
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


