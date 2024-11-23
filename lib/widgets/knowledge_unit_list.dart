import 'package:chatbot_agents/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:gap/gap.dart';

class KnowledgeUnitList extends StatefulWidget {
  final String knowledgeId;

  const KnowledgeUnitList(this.knowledgeId, {super.key});

  @override
  State<KnowledgeUnitList> createState() => _KnowledgeUnitListState();
}

class _KnowledgeUnitListState extends State<KnowledgeUnitList> {
  late List<KnowledgeUnit> knowledgeUnitList;

  @override
  void initState() {
    // call the fetch unit list api
    knowledgeUnitList = FakeData.knowledgeUnits;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(spacing[2]),
        itemCount: knowledgeUnitList.length,
        itemBuilder: (context, index) {
          return KnowledgeUnitListItem(knowledgeUnitList[index]);
        },
      ),
    );
  }
}
