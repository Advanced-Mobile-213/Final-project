import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/login",
    routes: {
      '/login' : (context) => LoginView(),
    },

  ));
}
