import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/text_input.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';

class AiBotDetailDialog extends StatefulWidget {
  final AiBot? updatingAiBot;
  const AiBotDetailDialog({super.key, this.updatingAiBot});

  @override
  State<AiBotDetailDialog> createState() => _AiBotDetailDialogState();
}

class _AiBotDetailDialogState extends State<AiBotDetailDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String _title;
  late void Function() _onConfirm;

  @override
  void initState() {
    super.initState();
    if (widget.updatingAiBot != null) {
      _nameController.text = widget.updatingAiBot!.assistantName;
      _instructionController.text = widget.updatingAiBot!.instructions ?? '';
      _descriptionController.text = widget.updatingAiBot!.description ?? '';
      _title = 'Update AI Bot';
      _onConfirm = onUpdateAiBot;
    } else {
      _title = 'New AI Bot';
      _onConfirm = onAddAiBot;
    }
  }

  void onAddAiBot() {
    print('--> AI Bot added');
  }

  void onUpdateAiBot() {
    print('--> AI Bot updated');
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: _title,
      onConfirm: _onConfirm,
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
          controller: _descriptionController,
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

void showAiBotDetailDialog(BuildContext context, {AiBot? updatingAiBot}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AiBotDetailDialog(
      updatingAiBot: updatingAiBot,
    ),
  );
}
