import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/knowledge_list_item.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:gap/gap.dart';

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(spacing[1]),
        itemCount: filteredKnowledgeList.length,
        itemBuilder: (context, index) {
          return KnowledgeListItem(knowledge: filteredKnowledgeList[index]);
        },
      ),
    );
  }
}
