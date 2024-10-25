import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/profile/profile_view.dart';
import 'package:chatbot_agents/views/prompt/prompt_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/login",
    routes: {
      '/login' : (context) => LoginView(),
      '/main' : (context) => MainView(),
    },

  ));
}
