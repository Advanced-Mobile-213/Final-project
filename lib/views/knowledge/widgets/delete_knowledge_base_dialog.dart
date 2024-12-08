import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../view_models/knowledge_view_model.dart';
import 'package:provider/provider.dart';

class DeleteKnowledgeBaseDialog extends StatefulWidget {
  final Knowledge knowledge; // The knowledge to be deleted

  const DeleteKnowledgeBaseDialog({super.key, required this.knowledge});

  @override
  State<DeleteKnowledgeBaseDialog> createState() => _DeleteKnowledgeBaseDialogState();
}

class _DeleteKnowledgeBaseDialogState extends State<DeleteKnowledgeBaseDialog> {
  bool _isLoading = false; // Manage the loading state

  @override
  Widget build(BuildContext context) {
    final KnowledgeViewModel readKnowledgeViewModel = context.read<KnowledgeViewModel>();

    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text(
        'Delete Knowledge Base',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.quaternaryText,
        ),
      ),
      content: Text(
        'Are you sure you want to delete the knowledge base: "${widget.knowledge.knowledgeName}"?',
        style: const TextStyle(fontSize: 16, color: AppColors.quaternaryText),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
            setState(() {
              _isLoading = true; // Set loading to true before deletion
            });

            try {
              await readKnowledgeViewModel.deleteKnowledge(id: widget.knowledge.id);

              Navigator.of(context).pop(); // Close the dialog after successful deletion
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error occurred: $e'),
                ),
              );
            } finally {
              setState(() {
                _isLoading = false; // Reset loading after operation
              });
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
              : const Text('Delete'),
        ),
      ],
    );
  }
}
