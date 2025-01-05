import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../views/prompt/widgets/prompt_list.dart';

class AddPromptDialog extends StatefulWidget {
  const AddPromptDialog({super.key});

  @override
  State<AddPromptDialog> createState() => _AddPromptDialogState();
}

class _AddPromptDialogState extends State<AddPromptDialog> {
  void _onAddPrompt() {
    print('--> onAddPrompt pressed');
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Add Prompts',
        onConfirm:(){
          _onAddPrompt();
          Navigator.of(context).pop();
        },
        children: const[PromptList()]);
  }
}

void showAddPromptDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddPromptDialog(),
  );
}
