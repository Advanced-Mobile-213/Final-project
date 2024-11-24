import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import 'package:gap/gap.dart';
import '../../../widgets/text_input.dart';
import 'prompt_category_selector.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';
import '../../../constants/prompt_category.dart';
import '../../../constants/spacing.dart';

const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);

class AddPromptDialog extends StatefulWidget {
  const AddPromptDialog({super.key});

  @override
  State<AddPromptDialog> createState() => _AddPromptDialogState();
}

class _AddPromptDialogState extends State<AddPromptDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController langueController = TextEditingController();
  bool isPublic = false;
  PromptCategory category = PromptCategory.business;

  void onConfirm() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        langueController.text.isNotEmpty) {
      final promptViewModel = context.read<PromptViewModel>();
      promptViewModel.createPrompt(
        title: titleController.text,
        description: descriptionController.text,
        content: contentController.text,
        language: langueController.text,
        category: category,
        isPublic: isPublic,
      );

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prompt added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDialog(
        title: 'Add prompt',
        onConfirm: onConfirm,
        children: [
          TextInput(
            label: 'Title',
            hintText: 'Enter prompt title',
            onChanged: (value) => titleController.text = value,
          ),
          Gap(spacing[2]),
          TextInput(
            label: 'Description',
            hintText: 'Enter prompt description',
            onChanged: (value) => descriptionController.text = value,
            lineNumbers: 3,
          ),
          Gap(spacing[2]),
          TextInput(
            label: 'Content',
            hintText: 'Enter prompt content',
            onChanged: (value) => contentController.text = value,
            lineNumbers: 8,
          ),
          Gap(spacing[2]),
          TextInput(
            label: 'Language',
            hintText: 'Enter prompt language',
            onChanged: (value) => langueController.text = value,
          ),
          Gap(spacing[2]),
          PromptCategorySelector(
            hasLabel: true,
            category: category,
            onChanged: (PromptCategory? value) {
              setState(() {
                category = value!;
              });
            },
          ),
          Gap(spacing[2]),
          Row(
            children: [
              const Text('Public', style: _textStyle),
              Gap(spacing[1]),
              Checkbox(
                value: isPublic,
                side: const BorderSide(color: Colors.white),
                onChanged: (bool? value) {
                  setState(() {
                    isPublic = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showAddPromptDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddPromptDialog(),
  );
}
