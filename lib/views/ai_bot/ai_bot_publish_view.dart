import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import './widgets/bot_configuration_list.dart';

class AiBotPublishView extends StatefulWidget {
  final AiBot aiBot;
  const AiBotPublishView(this.aiBot, {super.key});

  @override
  State<AiBotPublishView> createState() => _AiBotPublishViewState();
}

class _AiBotPublishViewState extends State<AiBotPublishView> {
  @override
  Widget build(BuildContext context) {
    return Screen(
        title: 'Publish',
        canGoBack: true,
        children: [BotConfigurationList(widget.aiBot.id)]);
  }
}
