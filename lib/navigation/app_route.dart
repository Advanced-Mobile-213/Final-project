import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/forgot_password/enter_email_view.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/protected_route.dart';
import 'package:chatbot_agents/views/register/register_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginView(),
  '/register': (context) => const RegisterView(),
  '/forgot_password': (context) => const EnterEmailView(),
  '/main': (context) => const ProtectedRoute(child: MainView()),
  '/subscription': (context) =>
      const ProtectedRoute(child: SubscriptionView()),
  '/email-reply': (context) => const ProtectedRoute(child: EmailReplyView()),
};