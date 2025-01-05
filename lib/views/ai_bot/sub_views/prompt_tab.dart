import 'package:flutter/material.dart';
import '../../../models/ai_bot/ai_bot.dart';
import '../../../widgets/wide_button.dart';
import '../../../widgets/text_input.dart';
import 'package:gap/gap.dart';
import '../../../constants/spacing.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';

class PromptTab extends StatefulWidget {
  final AiBot aiBot;
  const PromptTab(this.aiBot, {super.key});

  @override
  State<PromptTab> createState() => _PromptTabState();
}

class _PromptTabState extends State<PromptTab> {
  late SnackBarUtil _snackBarUtil;
  final TextEditingController _instructionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _snackBarUtil = SnackBarUtil(context);
    _instructionController.text = widget.aiBot.instructions ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final aiBotViewModel = context.watch<AiBotViewModel>();

    void onUpdatePress() async {
      await aiBotViewModel.updateAssistant(
        assistantId: widget.aiBot.id,
        assistantName: widget.aiBot.assistantName,
        instructions: _instructionController.text,
      );

      bool success = aiBotViewModel.success;
      if (success) {
        _snackBarUtil.showSuccess('Update successfully');
      } else {
        _snackBarUtil.showError('Update failed');
      }
    }

    final Widget footer;
    if (aiBotViewModel.isLoading) {
      footer = const Center(child: CircularProgressIndicator());
    } else {
      footer = WideButton(text: 'Update', onPressed: onUpdatePress);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(spacing[1]),
          TextInput(
            label: 'Instructions',
            hintText:
                "Design the bot's persona, features and workflows using natural language",
            lineNumbers: 25,
            controller: _instructionController,
          ),
          Gap(spacing[2]),
          footer,
        ],
      ),
    );
  }
}
