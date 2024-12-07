import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/view_models/knowledge_unit_view_model.dart';
import 'package:chatbot_agents/views/knowledge/widgets/create_new_unit_dialog.dart';
import 'package:chatbot_agents/views/knowledge/widgets/unit_list_tile.dart';
import 'package:chatbot_agents/views/knowledge/widgets/update_knowledge_base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);


class KnowledgeDetailView extends StatefulWidget{
  final Knowledge knowledge;
  const KnowledgeDetailView({super.key, required this.knowledge});

  @override
  State<KnowledgeDetailView> createState() => _KnowledgeDetailViewState();
}

class _KnowledgeDetailViewState extends State<KnowledgeDetailView>{
  late final KnowledgeUnitViewModel readKnowledgeUnitViewModel;
  late bool _isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readKnowledgeUnitViewModel = context.read<KnowledgeUnitViewModel>();
    _fetchKnowledgeUnits(widget.knowledge.id);
    _isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    final watchKnowledgeUnitViewModel = context.watch<KnowledgeUnitViewModel>();
    Knowledge knowledge = widget.knowledge;
    Widget content;
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),) ;
    } else if (readKnowledgeUnitViewModel.knowledgeUnits.isEmpty) {
      content = const Center(
          child: Text('No Knowledge Units Found', style: _emptyTextStyle));
    } else {
      content = ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: watchKnowledgeUnitViewModel.knowledgeUnits.length,
          itemBuilder: (context, index) {
            return UnitListTile(knowledgeUnit: watchKnowledgeUnitViewModel.knowledgeUnits[index],);
          }
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: AppColors.quaternaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Knowledge Detail",
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(knowledge.knowledgeName,
                          style: const TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                            color: AppColors.quaternaryText,
                          ),
                          onPressed: (){
                            _showUpdateKnowledgeBaseDialog(knowledge);
                          },
                        ),
                      ],
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      knowledge.description,
                      style: const TextStyle(
                        color: AppColors.quaternaryText,
                        fontSize: 16,
                      ),
                      maxLines: 3, // Limit number of visible lines for better UI
                      overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBackground,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: AppColors.quaternaryText,
                              width: 1,
                            ),
                          ),
                          child: Text('${knowledge.numUnits ?? 0} Units',
                            style: const TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 15,
                              
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBackground,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: AppColors.quaternaryText,
                              width: 1,
                            ),
                          ),
                          child: Text('${knowledge.totalSize ?? 0} Bytes',
                            style: const TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 15,
                              
                            ),
                          ),
                        ),
                       
                      ],
                    )
                  ),
                  // Show the knowledge description

                  Expanded(
                    child: content
                  ),
                ],

              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showCreateNewUnitDialog();
        },
        backgroundColor: AppColors.quaternaryBackground,
        child: const Icon(Icons.add,
          color: AppColors.primaryText,
        ),
      ),
    );
  }

  Future<void> _fetchKnowledgeUnits(String knowledgeId) async {
    await readKnowledgeUnitViewModel.getKnowledgeUnits(knowledgeId: knowledgeId);
    if (mounted) {
      setState(() {
        _isLoading = false; // Set loading state to false when data is fetched
      });
    }
  }

  void _showCreateNewUnitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewUnitDialog();
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
}