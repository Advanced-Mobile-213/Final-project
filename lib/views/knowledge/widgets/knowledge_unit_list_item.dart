import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.primaryBackground,
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(
    color: Colors.white,
    width: 1.0,
  ),
);

const _textDecoration = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class KnowledgeUnitListItem extends StatelessWidget {
  final KnowledgeUnit knowledgeUnit;

  const KnowledgeUnitListItem(this.knowledgeUnit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: spacing[2],
        vertical: spacing[2],
      ),
      decoration: _containerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(knowledgeUnit.name, style: _textDecoration)),
          Text(
            knowledgeUnit.status ? 'Active' : 'Inactive',
            style: _textDecoration.copyWith(
              color: knowledgeUnit.status ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
