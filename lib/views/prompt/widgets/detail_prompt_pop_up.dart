import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPromptPopUpDialog extends StatefulWidget{
  final int index;

  DetailPromptPopUpDialog({super.key, required this.index});

  
  @override
  State<DetailPromptPopUpDialog> createState() => _DetailPromptPopUpState();

}

class _DetailPromptPopUpState extends State<DetailPromptPopUpDialog> {
  final TextEditingController _nameInputFieldController = TextEditingController(text: 'This is prompt name');
  final TextEditingController _promptInputFieldController = TextEditingController(text: "This is prompt");
  final TextEditingController _descriptionInputFieldController = TextEditingController(text: 'This is prompt description');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Detail Prompt',
            style: TextStyle(
              color: AppColors.quaternaryText,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.star_border,
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
          ),
        ],
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Column(

              children:  <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text('Name:',
                    style: TextStyle(
                      color: AppColors.quaternaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  enabled: false,
                  controller: _nameInputFieldController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter Prompt Name',
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
                  ),
                  onSubmitted: (value) {

                  },
                ),
                
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text('Written by Author:',
                    style: TextStyle(
                      color: AppColors.quaternaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  enabled: false,
                  controller: _descriptionInputFieldController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter Prompt Description',
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
                  ),
                  onSubmitted: (value) {

                  },
                ),
               Container(
                margin: const EdgeInsets.only(top: 10, bottom: 2),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                    alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text('Prompt:',
                        style: TextStyle(
                          color: AppColors.quaternaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.file_copy,
                      color: AppColors.quaternaryText,
                    ),
                    
                  ],
                ),
              
               ),
               
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  enabled: false,
                  controller: _promptInputFieldController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'eg: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
                    hintMaxLines: 3,
                    contentPadding: const EdgeInsets.all(10),
                    hintStyle: const TextStyle(
                      color: AppColors.greyText,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) {

                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon:  const Icon(Icons.chat),
          label: const Text('Using this prompt'),
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground, // Text color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: TextStyle(fontSize: 16), // Text style
          ),
        ),
      ],
    );
  }
  
}