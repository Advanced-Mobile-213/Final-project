import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';


typedef OnImageCallback = Future<void> Function(ImageSource, {required BuildContext context}); 


class NonTextInputSelectionWidget extends StatefulWidget {
  final void Function(String) onPromptSelected;
  final OnImageCallback onImageButtonPressed;
  const NonTextInputSelectionWidget({Key? key, required this.onPromptSelected, required this.onImageButtonPressed}) : super(key: key);

  @override
  _NonTextInputSelectionWidgetState createState() => _NonTextInputSelectionWidgetState();
}

class _NonTextInputSelectionWidgetState extends State<NonTextInputSelectionWidget> {
  
  Future<void> _onImageButtonPressed(ImageSource source, {required BuildContext context}) async {
    try {
      await widget.onImageButtonPressed(source, context: context);
    } catch (e) {
      print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            leading: Icon(Icons.image, color: AppColors.tertiaryText),
            title: const Text('Upload Image',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () async {
              
              await _onImageButtonPressed(ImageSource.gallery, context: context);
              widget.onPromptSelected('');
            },
          ),
          ListTile(
            leading: Icon(Icons.file_upload, color: AppColors.tertiaryText),
            title: const Text('Upload file',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () {
              widget.onPromptSelected('');
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: AppColors.tertiaryText),
            title: const Text('Take Photo',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () async {
              
              await _onImageButtonPressed(ImageSource.camera, context: context);
              widget.onPromptSelected('');
            },
          ),
          Container(
            height: 1.0,
            color: AppColors.quaternaryBackground,
          ),
          ListTile(
            leading: Icon(Icons.text_fields, color: AppColors.tertiaryText),
            title: const Text('Prompt',
              style: TextStyle(
                color: AppColors.tertiaryText,
              ),
            ),
            onTap: () {
              widget.onPromptSelected('Prompt');
            },
          ),
        ],
      ),
    );
  }
}