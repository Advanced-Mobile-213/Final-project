import 'package:chatbot_agents/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/login",
    routes: {
      '/login' : (context) => LoginScreen(),
    },

  ));
}
