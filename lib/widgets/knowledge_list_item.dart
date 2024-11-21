import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_detail_view.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: Colors.white,
);

final BoxDecoration _containerDecoration = BoxDecoration(
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
  final void Function(Knowledge) onDeleted;

  const KnowledgeListItem(
      {required this.knowledge, required this.onDeleted, super.key});

  void onKnowledgeTap(BuildContext context, Knowledge knowledge) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KnowledgeDetailView(knowledge: knowledge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => onKnowledgeTap(context, knowledge),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing[2],
          vertical: spacing[1],
        ),
        decoration: _containerDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    knowledge.knowledgeName,
                    style: _titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    knowledge.description,
                    style: _descriptionTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            TouchableOpacity(
              onTap: () => onDeleted(knowledge),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
