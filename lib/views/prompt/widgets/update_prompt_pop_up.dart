import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/prompt/prompt.dart';
import 'package:chatbot_agents/constants/prompt_category.dart';
import 'package:chatbot_agents/constants/enum_language.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';

class UpdatePromptPopUpDialog extends StatefulWidget {
  //final int index;
  final Prompt prompt;

  //UpdatePromptPopUpDialog({Key? key, required this.index}) : super(key: key);
  const UpdatePromptPopUpDialog({super.key, required this.prompt});

  @override
  State<UpdatePromptPopUpDialog> createState() =>
      _UpdatePromptPopUpDialogState();
}

class _UpdatePromptPopUpDialogState extends State<UpdatePromptPopUpDialog> {
  late int _selectedIndexView;

  List<String> promptLanguages = EnumLanguage.getAllLanguages;
  List<String> promptCategories = PromptCategory.values
      .toList()
      .map((e) => e.toString().split('.').last)
      .toList();

  late String _selectedLanguage;
  final TextEditingController _nameInputFieldController =
      TextEditingController();
  late String _selectedCategory;
  final TextEditingController _contentInputFieldController =
      TextEditingController();
  final TextEditingController _descriptionInputFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedIndexView = widget.prompt.isPublic ? 2 : 1;

    _selectedLanguage = widget.prompt.language;
    _nameInputFieldController.text = widget.prompt.title;
    _selectedCategory = widget.prompt.category.id;
    _contentInputFieldController.text = widget.prompt.content;
    _descriptionInputFieldController.text = widget.prompt.description;
  }

  void _onPromptUpdated() async {
    PromptViewModel promptViewModel = context.read<PromptViewModel>();
    bool result = await promptViewModel.updatePrompt(
      id: widget.prompt.id!,
      title: _nameInputFieldController.text,
      category: PromptCategory.values
          .firstWhere((element) => element.id == _selectedCategory),
      content: _contentInputFieldController.text,
      description: _descriptionInputFieldController.text,
      isPublic: _selectedIndexView == 2,
      language: _selectedLanguage,
    );

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Prompt updated successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update prompt'),
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Update Prompt',
            style: TextStyle(
              color: AppColors.quaternaryText,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.quaternaryText,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Row(
                  //         children: <Widget>[
                  //           Radio<int>(
                  //             value: 1,
                  //             groupValue: _selectedIndexView,
                  //             splashRadius: 20,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _selectedIndexView = value!;
                  //               });
                  //             },
                  //             fillColor: const WidgetStatePropertyAll(
                  //                 AppColors.quaternaryText),
                  //             activeColor: Colors.blue,
                  //           ),
                  //           const Text(
                  //             'Private',
                  //             style: TextStyle(
                  //               color: AppColors.quaternaryText,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: <Widget>[
                  //           Radio<int>(
                  //             value: 2,
                  //             groupValue: _selectedIndexView,
                  //             splashRadius: 25,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _selectedIndexView = value!;
                  //               });
                  //             },
                  //             fillColor: const WidgetStatePropertyAll(
                  //                 AppColors.quaternaryText),
                  //           ),
                  //           const Text(
                  //             'Public',
                  //             style: TextStyle(
                  //               color: AppColors.quaternaryText,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  _selectedIndexView == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text(
                            'Prompt Language:',
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(),
                  _selectedIndexView == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedLanguage,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 15.0,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLanguage = newValue!;
                              });
                            },
                            items: promptLanguages
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      : Container(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Name:',
                      style: TextStyle(
                        color: AppColors.quaternaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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
                    onSubmitted: (value) {},
                  ),
                  _selectedIndexView == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text(
                            'Prompt Category:',
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(),
                  _selectedIndexView == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedCategory,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 15.0,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            },
                            items: promptCategories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      : Container(),
                  _selectedIndexView == 2
                      ? Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text(
                            'Description:',
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(),
                  _selectedIndexView == 2
                      ? TextField(
                          maxLines: null,
                          controller: _descriptionInputFieldController,
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
                          onSubmitted: (value) {},
                        )
                      : Container(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Prompt:',
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
                        hintText:
                            'Use square brackets [] to specify user input. Learn more',
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
                    controller: _contentInputFieldController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText:
                          'eg: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
                      hintMaxLines: 3,
                      contentPadding: const EdgeInsets.all(10),
                      hintStyle: const TextStyle(
                        color: AppColors.greyText,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (value) {},
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
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.tertiaryText,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _onPromptUpdated();
          },
          child: Text('Save'),
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground, // Text color
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: TextStyle(fontSize: 16), // Text style
          ),
        ),
      ],
    );
  }
}
