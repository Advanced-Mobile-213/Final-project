import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateNewKnowledgeBaseDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreateNewKnowledgeBaseDialogState();
  
}

class _CreateNewKnowledgeBaseDialogState extends State<CreateNewKnowledgeBaseDialog>{
  final TextEditingController _nameInputFieldController = TextEditingController();
  final TextEditingController _descriptionInputFieldController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create New Knowledge Base',
            maxLines: 3,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.quaternaryText,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close,
              color: AppColors.quaternaryText,
            ),
          ),
        ],
      ),
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FontAwesomeIcons.database,
                size: 50,
                color: AppColors.quaternaryText,
              ),  
              Row(
                children: [
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text("Knowledge Name",
                  style: TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 18,
                  ),
                ),
                ],
                
              ),
              TextFormField(
                maxLength: 50,
                minLines: 1,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                enabled: true,
                controller: _nameInputFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Max 50',
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: const EdgeInsets.all(5),
                  hintStyle: const TextStyle(
                    color: AppColors.greyText,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.secondaryBackground,
                      width: 0,
                    ),
                  ),
                  counterStyle: TextStyle(
                    color: AppColors.quaternaryText,
                  )
                  //errorText: 'Please input knowledge name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                
              
              ),
              const SizedBox(height: 16.0),
              
              Container(
                alignment: Alignment.centerLeft,
                child: const Text("Knowledge Description",
                    style: TextStyle(
                      color: AppColors.quaternaryText,
                      fontSize: 18,
                    ),
                ),
              ),
              TextFormField(
                maxLength: 2000,
                minLines: 3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                enabled: true,
                controller: _descriptionInputFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Enter description',
                  hintTextDirection: TextDirection.ltr,
                  contentPadding: const EdgeInsets.all(5),
                  hintStyle: const TextStyle(
                    color: AppColors.greyText,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.secondaryBackground,
                      width: 0,
                    ),
                  ),
                  counterStyle: TextStyle(
                    color: AppColors.quaternaryText,
                  )

                  //errorText: 'Please input knowledge name',

                ),
                validator: (value) {
                  return null;
                },
                
              
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
            style: TextStyle(
              color: AppColors.tertiaryText,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Define the action to be performed when the button is pressed
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground, // 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: TextStyle(fontSize: 16), // Text style
          ),
        ),
        
      ],
    );
  }
}