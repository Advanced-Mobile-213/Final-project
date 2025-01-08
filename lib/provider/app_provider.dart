import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:chatbot_agents/view_models/knowledge_view_model.dart';
import 'package:chatbot_agents/view_models/bot_configuration_view_model.dart';
import 'package:chatbot_agents/view_models/knowledge_unit_view_model.dart';
import 'package:chatbot_agents/view_models/email_reply_view_model.dart';
import 'package:chatbot_agents/view_models/profile_view_model.dart';
import 'package:chatbot_agents/view_models/main_view_model.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListConversationsViewModel()),
        ChangeNotifierProvider(create: (_) => ConversationViewModel()),
        ChangeNotifierProvider(create: (_) => PromptViewModel()),
        ChangeNotifierProvider(create: (_) => AiBotViewModel()),
        ChangeNotifierProvider(create: (_) => KnowledgeViewModel()),
        ChangeNotifierProvider(create: (_) => BotConfigurationViewModel()),
        ChangeNotifierProvider(create: (_) => KnowledgeUnitViewModel()),
        ChangeNotifierProvider(create: (_) => EmailReplyViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => MainViewModel()),
      ],
      child: child,
    );
  }
}