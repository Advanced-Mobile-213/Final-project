import 'dart:ffi';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPromptPopUpDialog extends StatefulWidget{
  
  @override
  State<AddPromptPopUpDialog> createState() => _AddPromptPopUpDialogState();
}

class _AddPromptPopUpDialogState extends State<AddPromptPopUpDialog> {
  int _selectedIndexView = 1;
  static const List<String> promptLanguage = ['English', 'Vietnamese', 'Japanese', 'India'];
  static const  List<String> promptCategory = ['AI', 'SEO', 'Content Writing', 'Web Development', 'Mobile Development', 'Design', 'Marketing', 'Business', 'Finance', 'Management', 'Sales', 'Customer Service', 'Human Resources', 'Product Management', 'Project Management', 'Data Science', 'Machine Learning', 'Deep Learning', 'Computer Vision', 'Natural Language Processing', 'Reinforcement Learning', 'Robotics', 'Cybersecurity', 'Blockchain', 'Cloud Computing', 'DevOps', 'Big Data', 'IoT', 'Quantum Computing', 'AR/VR', 'Game Development', 'Software Development', 'Hardware Development', 'Network Development', 'Database Development', 'Web Development', 'Mobile Development', 'Design', 'Marketing', 'Business', 'Finance', 'Management', 'Sales', 'Customer Service', 'Human Resources'];
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
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
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: promptCategory[0],
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
                    items: promptCategory
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
            Navigator.of(context).pop();
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