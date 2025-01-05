import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/view_models/knowledge_view_model.dart';
import 'package:chatbot_agents/views/knowledge/widgets/create_new_knowledge_base_dialog.dart';
import 'package:chatbot_agents/views/knowledge/widgets/delete_knowledge_base_dialog.dart';
import 'package:chatbot_agents/views/knowledge/widgets/update_knowledge_base_dialog.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../widgets/search_input.dart';
import 'knowledge_detail_view.dart';

// TODO: move to app properties
const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);

const TextStyle _descriptionTextStyle = TextStyle(
  color: AppColors.quaternaryText,
);
const TextStyle _titleTextStyle = TextStyle(
  color: AppColors.quaternaryText,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);


class KnowledgeListView extends StatefulWidget {
  const KnowledgeListView({super.key});

  @override
  State<KnowledgeListView> createState() => _KnowledgeListViewState();
}

class _KnowledgeListViewState extends State<KnowledgeListView> {
  late final KnowledgeViewModel readKnowledgeViewModel;
  late bool _isLoading;
  String _searchQuery = ''; // Track the search query
  List<Knowledge> _filteredKnowledges = []; // Store filtered knowledges
  @override
  void initState() {
    super.initState();
    readKnowledgeViewModel = context.read<KnowledgeViewModel>();
    _fetchKnowledges();
    _isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    final watchKnowledgeViewModel = context.watch<KnowledgeViewModel>();
    _filteredKnowledges = watchKnowledgeViewModel.knowledges
        .where((knowledge) => knowledge.knowledgeName.toLowerCase().contains(_searchQuery.toLowerCase())
     || knowledge.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    Widget content;
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),) ;
    } else if (readKnowledgeViewModel.knowledges.isEmpty) {
      content = const Center(
          child: Text('No Knowledge Found', style: _emptyTextStyle));
    } else {
      content = ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _filteredKnowledges.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(0,15.0,0,0),
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
                    _navigateToKnowledgeDetail(_filteredKnowledges[index]);
                  },
                  title: Text(
                    _filteredKnowledges[index].knowledgeName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: _titleTextStyle
                  ),
                  subtitle: Text(
                    _filteredKnowledges[index].description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: _descriptionTextStyle
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.quaternaryText),
                        onPressed: () {
                          _showUpdateKnowledgeBaseDialog(watchKnowledgeViewModel.knowledges[index]);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                          color: AppColors.quaternaryText,
                        ),
                        onPressed: () {
                          _showDeleteKnowledgeBaseDialog(watchKnowledgeViewModel.knowledges[index]);
                        },
                      ),
                    ],
                  )

              ),
            );
          }
      );
    }
    return Screen(
      title: 'Knowledge Base',
      titleButton: FloatingActionButton(
        onPressed: () { _showCreateNewKnowledgeBaseDialog();},
        backgroundColor: AppColors.secondaryBackground,
        child: const Icon(Icons.add, color: AppColors.quaternaryText),
      ),
      children: [
        SearchInput(onChanged: (value) {
          setState(() {
            _searchQuery= value;
          });
        }),
        Expanded(
          child: content,
        ),
      ],
    );
  }

  Future<void> _fetchKnowledges() async {
    await readKnowledgeViewModel.getKnowledges();
    if (mounted) {
      setState(() {
        _isLoading = false; // Set loading state to false when data is fetched
      });
    }
  }

  void _showCreateNewKnowledgeBaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewKnowledgeBaseDialog();
      },
    );
  }

  void _showUpdateKnowledgeBaseDialog(Knowledge knowledge) {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateKnowledgeBaseDialog(knowledge: knowledge,);
      },
    );
  }

  void _showDeleteKnowledgeBaseDialog(Knowledge knowledge) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteKnowledgeBaseDialog(knowledge: knowledge);
      },
    );
  }

  void _navigateToKnowledgeDetail(Knowledge selectedKnowledge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KnowledgeDetailView(knowledge: selectedKnowledge),
      ),
    );
  }

}
