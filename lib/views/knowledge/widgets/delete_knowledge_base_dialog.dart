import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../view_models/knowledge_view_model.dart';
import 'package:provider/provider.dart';

class DeleteKnowledgeBaseDialog extends StatelessWidget {
  final Knowledge knowledge; // The knowledge to be deleted

  const DeleteKnowledgeBaseDialog({super.key, required this.knowledge});
  
  
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
            color:  AppColors.quaternaryText
        ),
      ),
      content: Text(
        'Are you sure you want to delete the knowledge base: "${knowledge.knowledgeName}"?',
        style: const TextStyle(fontSize: 16, color:  AppColors.quaternaryText),
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
          onPressed: () {
            // Call the delete function from KnowledgeViewModel
            readKnowledgeViewModel.deleteKnowledge(id: knowledge.id);

            // Close the dialog
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
