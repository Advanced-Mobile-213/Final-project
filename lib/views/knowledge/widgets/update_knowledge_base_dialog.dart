import 'package:chatbot_agents/view_models/knowledge_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/text_input.dart';
import '../../../models/knowledge/knowledge.dart';

class UpdateKnowledgeBaseDialog extends StatefulWidget {
  final Knowledge knowledge; // Pass the knowledge object to the dialog

  const UpdateKnowledgeBaseDialog({super.key, required this.knowledge});

  @override
  State<StatefulWidget> createState() => _UpdateKnowledgeBaseDialogState();
}

class _UpdateKnowledgeBaseDialogState extends State<UpdateKnowledgeBaseDialog> {
  late final TextEditingController _nameInputFieldController;
  late final TextEditingController _descriptionInputFieldController;
  late final KnowledgeViewModel readKnowledgeViewModel;
  late final GlobalKey<FormState> _formKey;
  bool _isLoading = false; // Manage loading state

  @override
  void initState() {
    super.initState();
    _nameInputFieldController = TextEditingController(text: widget.knowledge.knowledgeName);
    _descriptionInputFieldController = TextEditingController(text: widget.knowledge.description);
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
          const Expanded(
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
          constraints: const BoxConstraints(maxWidth: 400),
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
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.tertiaryText),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              setState(() {
                _isLoading = true;
              });
              try {
                final updatedKnowledge = await readKnowledgeViewModel.updateKnowledge(
                  id: widget.knowledge.id,
                  knowledgeName: _nameInputFieldController.text,
                  description: _descriptionInputFieldController.text,
                );
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pop(
                    updatedKnowledge
                ); // Close dialog on success
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error updating knowledge base: $e'),
                  ),
                );
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : const Text('Save', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
