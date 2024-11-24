import 'package:flutter/material.dart';
import 'package:chatbot_agents/views/knowledge/widgets/knowledge_list_item.dart';
import 'package:chatbot_agents/constants/fake_data.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';

final List<Knowledge> knowledgeList = FakeData.knowledge;

class KnowledgeList extends StatefulWidget {
  final String searchingTitle;

  const KnowledgeList({required this.searchingTitle, super.key});

  @override
  State<KnowledgeList> createState() => _KnowledgeListState();
}

class _KnowledgeListState extends State<KnowledgeList> {
  List<Knowledge> get filteredKnowledgeList {
    if (widget.searchingTitle.isEmpty) {
      return knowledgeList;
    }
    return knowledgeList
        .where((knowledge) => knowledge.knowledgeName
            .toLowerCase()
            .contains(widget.searchingTitle.toLowerCase()))
        .toList();
  }

  void onDelete(Knowledge knowledge) {
    setState(() {
      knowledgeList.remove(knowledge);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Knowledge deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(spacing[2]),
        itemCount: filteredKnowledgeList.length,
        itemBuilder: (context, index) {
          return KnowledgeListItem(
            knowledge: filteredKnowledgeList[index],
            onDeleted: onDelete,
          );
        },
      ),
    );
  }
}
