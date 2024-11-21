import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:gap/gap.dart';

class KnowledgeListView extends StatefulWidget {
  const KnowledgeListView({super.key});

  @override
  State<KnowledgeListView> createState() => _KnowledgeListViewState();
}

class _KnowledgeListViewState extends State<KnowledgeListView> {
  String searchTitle = '';

  void onSearchInputChanged(String value) {
    setState(() {
      searchTitle = value;
    });
  }

  void onDialogOpen(BuildContext context) {
    showAddKnowledgeDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Knowledge',
      titleButton: WideButton(
        width: 100,
        text: 'Add',
        onPressed: () {
          onDialogOpen(context);
        },
      ),
      children: [
        SearchInput(
          onChanged: onSearchInputChanged,
          hintText: 'Knowledge title',
        ),
        Gap(spacing[2]),
        KnowledgeList(searchingTitle: searchTitle),
      ],
    );
  }
}
