import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/prompt/widgets/add_prompt_pop_up.dart';
import 'package:chatbot_agents/views/prompt/widgets/confirm_delete_prompt_pop_up.dart';
import 'package:chatbot_agents/views/prompt/widgets/detail_prompt_pop_up.dart';
import 'package:chatbot_agents/views/prompt/widgets/update_prompt_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyPromptView extends StatelessWidget {
  MyPromptView({Key? key}) : super(key: key);

  void _showAddPromptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddPromptPopUpDialog();
        }
    );
  }

  void _showConfirmDeletePromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDeletePromptPopUpDialog(index: index,);
        }
    );
  }

  void _showDetailPromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailPromptPopUpDialog(index: index);
        }
    );
  }

  void _showUpdatePromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdatePromptPopUpDialog(index: index);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0
      ),
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0
            ),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: AppColors.quaternaryBackground,
                width: 1.0,
              )
            ),
            child: ListTile(
              onTap: () => _showDetailPromptDialog(context, index),
              title: Text(
                'Prompt ${index + 1}',
                style: const TextStyle(
                  color: AppColors.quaternaryText,
                  fontSize: 20.0,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _showConfirmDeletePromptDialog(context, index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.quaternaryText,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _showUpdatePromptDialog(context, index);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.quaternaryText,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _showDetailPromptDialog(context, index);
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }

}
