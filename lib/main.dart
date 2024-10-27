import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/register/register_view.dart';
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
      '/register': (context) => RegisterView(),
      '/main' : (context) => MainView(),
      '/subscription': (context) => SubscriptionView(),
      '/email-reply': (context) => EmailReplyView(),
      '/knowledge-detail': (context) => KnowledgeDetailView(),
    },

  ));
}
