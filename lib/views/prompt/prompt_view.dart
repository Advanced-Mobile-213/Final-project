import 'package:chatbot_agents/views/prompt/sub_views/favorites_prompt_view.dart';
import 'package:chatbot_agents/views/prompt/sub_views/my_prompt_view.dart';
import 'package:chatbot_agents/views/prompt/sub_views/public_prompt_view.dart';
import 'package:chatbot_agents/views/prompt/widgets/add_prompt_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class PromptView extends StatefulWidget {
  const PromptView({Key? key}) : super(key: key);

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  static const List<int> _indexView = [0,1,2];
  int _selectedIndexView = 0;
  int _selectedIndexCategory = 0;

  Widget switchView(int index) {
    switch (index) {
      case 0:
        return MyPromptView();
      case 1:
        return PublicPromptView();
      case 2:
        return FavoritesPromptView();
      default:
        return MyPromptView();
    }
  }

  void _showAddPromptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddPromptPopUpDialog();
        }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryBackground,
          title: Text('Prompt Library',
              style: const TextStyle(
                  color: AppColors.quaternaryText,
              )
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showAddPromptDialog(context);
                },
                icon: Icon(
                  Icons.add_circle,
                  color: AppColors.quaternaryText,
                )
            )
          ],
        ),
        body: Container(
          color: AppColors.primaryBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 5.0
                  ),
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndexView = _indexView[0];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 5.0
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _selectedIndexView == _indexView[0]
                                      ? AppColors.secondaryBackground
                                      : AppColors.quaternaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'My Prompt',
                              style: TextStyle(
                                color: _selectedIndexView == _indexView[0]
                                        ? AppColors.quaternaryText
                                        : AppColors.primaryText,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndexView = _indexView[1];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 5.0
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _selectedIndexView == _indexView[1]
                                      ? AppColors.secondaryBackground
                                      : AppColors.quaternaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Public Prompt',
                              style: TextStyle(
                                color: _selectedIndexView == _indexView[1]
                                        ? AppColors.quaternaryText
                                        : AppColors.primaryText,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),           
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              _selectedIndexView = _indexView[2];
                            })
                          },
                          child:   Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 5.0
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _selectedIndexView == _indexView[2]
                                      ? AppColors.secondaryBackground
                                      : AppColors.quaternaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Favorites Prompt',
                              style: TextStyle(
                                color: _selectedIndexView == _indexView[2]
                                        ? AppColors.quaternaryText
                                        : AppColors.primaryText,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
          
                        ),  
                        
                      ],
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 5.0
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.grey,
                              hintText: 'Search prompt here ...',
                              contentPadding: const EdgeInsets.only(top: 2),
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),

                              ),
                            ),
                            onSubmitted: (searchTerm){

                            },
                          )
                      )

                  ),
                ],
              ),
              _selectedIndexView == _indexView[1]
                ?  Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0
                  ),
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i=0; i<5; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 2.0
                            ),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  _selectedIndexCategory = i;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: i==_selectedIndexCategory ? AppColors.quaternaryText : AppColors.primaryBackground,
                                backgroundColor: i == _selectedIndexCategory ? AppColors.secondaryBackground : AppColors.quaternaryBackground,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Padding
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child:  Text(
                                'Category ${i+1}',
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                )
                : Container(),
              
              Expanded(
                child: switchView(_selectedIndexView),
              ),
            ],
          ),

        ),
      );
      
  }
}