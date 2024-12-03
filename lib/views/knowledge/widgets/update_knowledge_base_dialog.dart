import 'package:chatbot_agents/view_models/knowledge_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/text_input.dart';
import '../../../models/knowledge/knowledge.dart';

class UpdateKnowledgeBaseDialog extends StatefulWidget {
  final Knowledge knowledge; // Pass the knowledge object to the dialog

  const UpdateKnowledgeBaseDialog({Key? key, required this.knowledge}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdateKnowledgeBaseDialogState();
}

class _UpdateKnowledgeBaseDialogState extends State<UpdateKnowledgeBaseDialog> {
  late final TextEditingController _nameInputFieldController;
  late final TextEditingController _descriptionInputFieldController;
  late final KnowledgeViewModel readKnowledgeViewModel;
  late final _formKey;

  @override
  void initState() {
    super.initState();
    _nameInputFieldController = TextEditingController(text: widget.knowledge.knowledgeName); // Set initial value from Knowledge object
    _descriptionInputFieldController = TextEditingController(text: widget.knowledge.description); // Set initial value from Knowledge object
    readKnowledgeViewModel = context.read<KnowledgeViewModel>();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded( // Ensure title text doesn't overflow
            child: Text(
              'Update Knowledge Base',
              maxLines: 2,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.quaternaryText,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, color: AppColors.quaternaryText),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400), // Set a max width to prevent overflow
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                TextInput(
                  label: 'Name',
                  hintText: "Max 50 characters",
                  controller: _nameInputFieldController,
                  maxLength: 50,
                  isRequired: true,
                ),
                const SizedBox(height: 16.0),
                TextInput(
                  label: "Description",
                  hintText: "Enter description",
                  controller: _descriptionInputFieldController,
                  maxLength: 2000,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.tertiaryText),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final name = _nameInputFieldController.text;
              final description = _descriptionInputFieldController.text;
              // Call the update method instead of create (assuming an update method exists)
              readKnowledgeViewModel.updateKnowledge(
                id: widget.knowledge.id, // Pass the ID of the knowledge to update
                knowledgeName: name,
                description: description,
              );
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Save', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
