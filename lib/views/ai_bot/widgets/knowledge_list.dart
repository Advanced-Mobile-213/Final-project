import 'package:flutter/material.dart';
import '../../../constants/fake_data.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../constants/spacing.dart';
import 'package:gap/gap.dart';
import 'knowledge_list_item.dart';

List<Knowledge> knowledgeItems = FakeData.knowledge;

class KnowledgeList extends StatefulWidget {
  const KnowledgeList({super.key});

  @override
  State<KnowledgeList> createState() => _KnowledgeListState();
}

class _KnowledgeListState extends State<KnowledgeList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => KnowledgeListItem(knowledgeItems[index]),
          separatorBuilder: (context, index) => Gap(spacing[2]),
          itemCount: knowledgeItems.length),
    );
  }
}
