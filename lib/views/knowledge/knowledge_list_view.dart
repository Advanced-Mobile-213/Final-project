import 'package:chatbot_agents/views/knowledge/widgets/create_new_knowledge_base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/widgets/widget.dart';

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
          'Knowledge Base',
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
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.quaternaryBackground,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        _navigateToKnowledgeDetail();
                      },
                      title: Text(
                        'Knowledge Base $index',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppColors.quaternaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Units: $index',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppColors.quaternaryText,
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                          color: AppColors.quaternaryText,
                        ),
                        onPressed: () {},
                      ),
                      
                    ),
                  );
                }
              ),
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateNewKnowledgeBaseDialog();
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.secondaryBackground,
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
