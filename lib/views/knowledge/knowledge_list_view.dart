import 'package:chatbot_agents/views/knowledge/widgets/create_new_knowledge_base_dialog.dart';
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            return SingleChildScrollView(
              child: SizedBox(
                width: availableWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PublishCard(
                      name: 'Company resources',
                      status: '',
                      buttonText: 'enable',
                      onTap: () {},
                    ),
                    const Gap(32),
                    PublishCard(
                      name: 'Self researching',
                      status: '',
                      buttonText: 'disable',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCreateNewKnowledgeBaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewKnowledgeBaseDialog();
      },
    );
  }

  void _navigateToKnowledgeDetail() {
    Navigator.pushNamed(context, '/knowledge-detail');
  }

}
