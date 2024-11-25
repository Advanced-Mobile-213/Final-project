import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/ai_bot_list.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'widgets/ai_bot_detail_dialog.dart';
import 'package:gap/gap.dart';
import './widgets/ai_bot_filter.dart';
import '../../constants/enum_ai_bot_view_mode.dart';

class AiBotView extends StatefulWidget {
  const AiBotView({super.key});

  @override
  State<AiBotView> createState() => _AiBotViewState();
}

class _AiBotViewState extends State<AiBotView> {
  String query = '';
  EnumAiBotViewMode selectedViewMode = EnumAiBotViewMode.all;

  void onTextChange(String text) {
    setState(() {
      query = text;
    });
  }

  void onViewModeChange(EnumAiBotViewMode mode) {
    setState(() {
      selectedViewMode = mode;
    });
  }

  void onNewAiBotPressed(BuildContext context) {
    showAiBotDetailDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: 'AI Bot',
        titleButton: FloatingActionButton(
          onPressed: () => onNewAiBotPressed(context),
          backgroundColor: AppColors.secondaryBackground,
          child: const Icon(Icons.add, color: AppColors.quaternaryText),
        ),
        children: [
          SearchInput(hintText: 'AI Bot Name', onChanged: onTextChange),
          Gap(spacing[3]),
          AiBotList(query),
        ]);
  }
}
