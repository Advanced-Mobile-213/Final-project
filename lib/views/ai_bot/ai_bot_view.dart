import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/ai_bot_list.dart';
import 'package:chatbot_agents/constants/spacing.dart';

class AiBotView extends StatefulWidget {
  const AiBotView({super.key});

  @override
  State<AiBotView> createState() => _AiBotViewState();
}

class _AiBotViewState extends State<AiBotView> {
  String searchingText = '';

  void onTextChange(String text) {
    setState(() {
      searchingText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: 'AI Bot',
        titleButton: WideButton(
          width: 100,
          text: 'Add',
          onPressed: () {},
        ),
        children: [
          SearchInput(hintText: 'AI Bot Name', onChanged: onTextChange),
          Gap(spacing[3]),
          AiBotList(searchingText),
        ]);
  }
}
