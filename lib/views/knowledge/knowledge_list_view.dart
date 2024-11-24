import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/views/knowledge/widgets/knowledge_list.dart';
import 'package:chatbot_agents/views/knowledge/widgets/add_knowledge_dialog.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';


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
    return Scaffold(
      body:  Screen(
        title: 'Knowledge',
        // titleButton: WideButton(
        //   width: 100,
        //   text: 'Add',
        //   onPressed: () {
        //     onDialogOpen(context);
        //   },
        // ),
        titleButton:  FloatingActionButton(
          onPressed: () => {
          onDialogOpen(context)
          },
          //_createNewThreadDialog(context),
          backgroundColor: AppColors.secondaryBackground,
          child: const Icon(
            Icons.add,
            color: AppColors.quaternaryText,
          ),
        ),
        children: [
          SearchInput(
            onChanged: onSearchInputChanged,
            hintText: 'Knowledge title',
          ),
          Gap(spacing[2]),
          KnowledgeList(searchingTitle: searchTitle),
        ],
      ),

    ) ;
  }
}
