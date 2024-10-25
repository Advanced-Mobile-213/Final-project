import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
typedef PromptSelectedCallback = void Function(String);

class PromptSelectionWidget extends StatefulWidget {
  PromptSelectedCallback onPromptSelected;
  PromptSelectionWidget({super.key, required this.onPromptSelected});

  @override
  _PromptSelectionWidgetState createState() => _PromptSelectionWidgetState();
}

class _PromptSelectionWidgetState extends State<PromptSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.quaternaryBackground,
          width: 1.0,
        )
       
      ),
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('My Prompt:',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () {
             
            },
          ),
          ListTile(
            title: const Text('Prompt 1',
              style: TextStyle(
                color: AppColors.quaternaryText,
              ),
            ),
            onTap: () {
              widget.onPromptSelected('Prompt 1');
            },
          ),
          ListTile(
            title: const Text('Public Prompt:',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () {
             
            },
          ),
          ListTile(
            title: const Text('Prompt 2',
              style: TextStyle(
                color: AppColors.quaternaryText,
              ),
            ),
            onTap: () {
              widget.onPromptSelected('Prompt 2');
            },
          ),
          ListTile(
            title: const Text('Prompt 3',
              style: TextStyle(
                color: AppColors.quaternaryText,
              ),
            ),
            onTap: () {
              widget.onPromptSelected('Prompt 3');
            },
          ),
        ],
      ),
    );
  }
}