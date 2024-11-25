import 'package:flutter/material.dart';
import '../../../models/ai_bot/ai_bot.dart';
import '../../../widgets/wide_button.dart';
import 'package:gap/gap.dart';
import '../../../constants/spacing.dart';
import '../widgets/knowledge_list.dart';
import '../widgets/add_knowledge_dialog.dart';

class KnowledgeTab extends StatefulWidget {
  final AiBot aiBot;
  const KnowledgeTab(this.aiBot, {super.key});

  @override
  State<KnowledgeTab> createState() => _KnowledgeTabState();
}

class _KnowledgeTabState extends State<KnowledgeTab> {
  void _onAddKnowledgePress() {
    showAddKnowledgeDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      WideButton(text: 'Add Knowledge', onPressed: _onAddKnowledgePress),
      Gap(spacing[4]),
      const KnowledgeList()
    ]);
  }
}
