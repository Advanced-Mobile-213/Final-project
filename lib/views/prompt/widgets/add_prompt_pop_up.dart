import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/constants/enum_language.dart';
import 'package:chatbot_agents/constants/enum_prompt_category.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPromptPopUpDialog extends StatefulWidget{
  const AddPromptPopUpDialog({super.key});
  
  @override
  State<AddPromptPopUpDialog> createState() => _AddPromptPopUpDialogState();
}

class _AddPromptPopUpDialogState extends State<AddPromptPopUpDialog> {
  int _selectedIndexView = 1;
  

  static const List<String> promptLanguage = EnumLanguage.getAllLanguages;
  static List<PromptCategory> promptCategory = PromptCategory.values;
  late PromptViewModel _promptViewModel;
  PromptCategory dropdownValue = promptCategory[0];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _promptViewModel = context.read<PromptViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
        children: <Widget>[
          const Text('Add Prompt',
            style: TextStyle(
              color: AppColors.quaternaryText,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, color: AppColors.quaternaryText,),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(

                children:  <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio<int>(
                              value: 1,
                              groupValue: _selectedIndexView,
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  _selectedIndexView = value!;
                                });
                              },
                              fillColor: const WidgetStatePropertyAll(AppColors.quaternaryText),
                              activeColor: Colors.blue,
                            ),
                            const Text('Private',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio<int>(
                              value: 2,
                              groupValue: _selectedIndexView,
                              splashRadius: 25,
                              onChanged: (value) {
                                setState(() {
                                  _selectedIndexView = value!;
                                });
                              },
                              fillColor: const WidgetStatePropertyAll(AppColors.quaternaryText),
                            ),
                            const Text('Public',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              
                  _selectedIndexView == 2 ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text('Prompt Language:',
                      style: TextStyle(
                        color: AppColors.quaternaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ): Container(),

                  _selectedIndexView == 2 ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: promptLanguage[0],
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: AppColors.primaryText,
                        fontSize: 15.0,
                      ),
                      
                      onChanged: (String? newValue) {
                        // setState(() {
                        //   dropdownValue = newValue!;
                        // });
                      },
                      items: promptLanguage
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ): Container(),

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
                    controller: _nameController,
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

                  _selectedIndexView == 2 ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text('Prompt Category:',
                      style: TextStyle(
                        color: AppColors.quaternaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ): Container(),

                  _selectedIndexView == 2 ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<PromptCategory>(
                      isExpanded: true,
                      value: promptCategory[0],
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: AppColors.primaryText,
                        fontSize: 15.0,
                      ),
                      
                      onChanged: (PromptCategory? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: promptCategory
                          .map<DropdownMenuItem<PromptCategory>>((PromptCategory value) {
                            return DropdownMenuItem<PromptCategory>(
                              value: value,
                              child: Text(value.title),
                            );
                        }).toList(),
                    ),
                  ) : Container(),

                  _selectedIndexView == 2 ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text('Description:',
                      style: TextStyle(
                        color: AppColors.quaternaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ) : Container(),

                  _selectedIndexView == 2 ? TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Describe your prompt here',
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (value) {

                    },
                  ) : Container(),

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

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: TextField(
                      maxLines: 2,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.tertiaryBackground,
                        hintText: 'Use square brackets [] to specify user input. Learn more',
                        hintMaxLines: 3,
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: const TextStyle(
                          color: AppColors.quaternaryText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                      ),
                    ),
                  ),

                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _contentController,
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
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            
            Navigator.of(context).pop();

          },
          child: const Text('Cancel',
            style: TextStyle(
              color: AppColors.tertiaryText,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async  {
            await _promptViewModel.createPrompt(
              category: PromptCategory.other, 
              content: _contentController.text, 
              description: '', 
              isPublic: false, 
              language: EnumLanguage.ENGLISH, 
              title: _nameController.text
            );
            // Define the action to be performed when the button is pressed
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_promptViewModel.newPrompt!=null ? 'Prompt created successfully' : 'Failed to create prompt'),
                backgroundColor: _promptViewModel.newPrompt!=null ? Colors.green : Colors.red,
              ),
            );
            
          },
          child: Text('Save'),
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