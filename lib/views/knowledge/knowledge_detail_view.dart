import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/knowledge/widgets/create_new_unit_dialog.dart';
import 'package:chatbot_agents/views/knowledge/widgets/unit_list_tile.dart';
import 'package:flutter/material.dart';

class KnowledgeDetailView extends StatefulWidget{
  @override
  State<KnowledgeDetailView> createState() => _KnowledgeDetailViewState();
}

class _KnowledgeDetailViewState extends State<KnowledgeDetailView>{
  final int units = 15;

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Knowledge Detail',
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
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Knowledge 1', 
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                            color: AppColors.quaternaryText,
                          ),
                          onPressed: (){},
                        ),
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
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
                          child: Text('$units Units', 
                            style: TextStyle(
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
                          child: Text('$units Bytes', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 15,
                              
                            ),
                          ),
                        ),
                       
                      ],
                    )
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: units,
                      itemBuilder: (context, index) {
                        return UnitListTile(index: index);
                      }
                    ),
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
        child: const Icon(Icons.add,
          color: AppColors.primaryText,
        ),
        backgroundColor: AppColors.quaternaryBackground,
      ),
    );
  }

  void _showCreateNewUnitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewUnitDialog();
      },
    );
  }
}