import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/text_input.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';

class AiBotDetailDialog extends StatefulWidget {
  final AiBot? updatingAiBot;
  const AiBotDetailDialog({super.key, this.updatingAiBot});

  @override
  State<AiBotDetailDialog> createState() => _AiBotDetailDialogState();
}

class _AiBotDetailDialogState extends State<AiBotDetailDialog> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _instructionController =
      TextEditingController(text: '');
  final TextEditingController _descriptionController =
      TextEditingController(text: '');
  late String _title;

  @override
  void initState() {
    super.initState();
    if (widget.updatingAiBot != null) {
      _nameController.text = widget.updatingAiBot!.assistantName;
      _instructionController.text = widget.updatingAiBot!.instructions ?? '';
      _descriptionController.text = widget.updatingAiBot!.description ?? '';
      _title = 'Update AI Bot';
    } else {
      _title = 'New AI Bot';
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiBotViewModel = context.read<AiBotViewModel>();

    void onAddAiBot() async {
      await aiBotViewModel.createAssistant(
        assistantName: _nameController.text,
        instructions: _instructionController.text,
        description: _descriptionController.text,
      );
    }

    void onUpdateAiBot() async {
      await aiBotViewModel.updateAssistant(
        assistantId: widget.updatingAiBot!.id,
        assistantName: _nameController.text,
        instructions: _instructionController.text,
        description: _descriptionController.text,
      );
    }

    return CustomDialog(
      title: _title,
      onConfirm: widget.updatingAiBot != null ? onUpdateAiBot : onAddAiBot,
      children: [
        TextInput(
          label: 'Name',
          hintText: 'Enter chat bot name',
          controller: _nameController,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Instruction',
          hintText: 'Enter chat bot instruction',
          controller: _instructionController,
          lineNumbers: 3,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Description',
          hintText: 'Enter chat bot description',
          controller: _descriptionController,
          lineNumbers: 3,
        ),
      ],
    );
  }
}

void showAiBotDetailDialog(BuildContext context,
    {AiBot? updatingAiBot,
    Function(String)? onAddUpdateSuccess,
    Function(String)? onAddUpdateFailed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AiBotDetailDialog(
      updatingAiBot: updatingAiBot,
    ),
  );
}
