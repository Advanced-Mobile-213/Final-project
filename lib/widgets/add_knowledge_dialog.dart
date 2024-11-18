import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'custom_dialog.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';
import 'text_input.dart';

class AddKnowledgeDialog extends StatefulWidget {
  const AddKnowledgeDialog({super.key});

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _onConfirm() {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      Knowledge knowledge = Knowledge(
        createdAt: DateTime.now(),
        knowledgeName: _nameController.text,
        description: _descriptionController.text,
        userId: '1',
      );

      FakeData.knowledge.add(knowledge);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Knowledge added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Add knowledge',
      onConfirm: _onConfirm,
      children: [
        TextInput(
          label: 'Name',
          hintText: 'Enter knowledge name',
          onChanged: (value) => _nameController.text = value,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Description',
          hintText: 'Enter knowledge description',
          onChanged: (value) => _descriptionController.text = value,
        )
      ],
    );
  }
}

void showAddKnowledgeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddKnowledgeDialog(),
  );
}
