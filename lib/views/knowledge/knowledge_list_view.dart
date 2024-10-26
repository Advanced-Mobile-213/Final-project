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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme: const IconThemeData(color: AppColors.quaternaryText),
        title: const Text(
          'Knowledge',
          style: TextStyle(
            color: AppColors.quaternaryText,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Container(
        color: AppColors.primaryBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Bar
            SearchInput(onChanged: (value) {}),
            
          ],
        ),
      )
    );
  }
}
