import 'package:flutter/material.dart';
import '../../../models/ai_bot/ai_bot.dart';
import '../../../widgets/wide_button.dart';
import '../../../views/prompt/widgets/prompt_list.dart';
import 'package:gap/gap.dart';
import '../../../constants/spacing.dart';
import '../widgets/add_prompt_dialog.dart';

class PromptTab extends StatefulWidget {
  final AiBot aiBot;
  const PromptTab(this.aiBot, {super.key});

  @override
  State<PromptTab> createState() => _PromptTabState();
}

class _PromptTabState extends State<PromptTab> {
  void _onAddPromptPress() {
    showAddPromptDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      WideButton(text: 'Add Prompt', onPressed: _onAddPromptPress),
      Gap(spacing[4]),
      const PromptList()
    ]);
  }
}
