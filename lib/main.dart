import 'package:chatbot_agents/views/ai_bot/chat_thread_view.dart';
import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/profile/profile_view.dart';
import 'package:chatbot_agents/views/prompt/prompt_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBackground),
          useMaterial3: true,
    ),
    initialRoute: "/login",
    routes: {
      '/login' : (context) => LoginView(),
      '/main' : (context) => MainView(),
      '/subscription': (context) => const SubscriptionView(),
      '/email-reply': (context) => EmailReplyView(),
    },

  ));
}
