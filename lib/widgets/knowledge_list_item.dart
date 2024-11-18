import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: Colors.white,
);

final BoxDecoration _cotainerDecoration = BoxDecoration(
  color: AppColors.tertiaryBackground.withOpacity(0.3),
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(
    color: Colors.white,
    width: 1.0,
  ),
);

// The widget
class KnowledgeListItem extends StatelessWidget {
  final Knowledge knowledge;

  const KnowledgeListItem({required this.knowledge, super.key});

  void onKnowledgeTap(Knowledge knowledge) {
    print('--> KnowledgeListView: ${knowledge}');
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => onKnowledgeTap(knowledge),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing[2],
          vertical: spacing[1],
        ),
        decoration: _cotainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(knowledge.knowledgeName, style: _titleTextStyle),
            Text(knowledge.description, style: _descriptionTextStyle),
          ],
        ),
      ),
    );
  }
}
