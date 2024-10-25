import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PromptBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PromptBottomSheetState();
  
}

class _PromptBottomSheetState extends State<PromptBottomSheet> {
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
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0
            ),
            child: ListTile(
              title: const Text('Grammar Correction',
                style: TextStyle(
                  color: AppColors.tertiaryText,
                  fontSize: 20,
                ),
              ),
              onTap: () {
               
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0
            ),
            child: ListTile(
              title: const Text('Prompt Description',
                style: TextStyle(
                  color: AppColors.quaternaryText,
                  fontSize: 10.0,
                ),
              ),
              onTap: () {
                
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0
            ),
            child: TextField(
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter your keyword',
                hintStyle: TextStyle(
                  color: AppColors.quaternaryText,
                  fontSize: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.quaternaryBackground,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.quaternaryBackground,
                    width: 1.0,
                  ),
                ),
              ),
            )
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('Send',
            style: TextStyle(
              color: AppColors.tertiaryText,
            ),
          ),
          )
        ],
      ),
    );
  }
  
}