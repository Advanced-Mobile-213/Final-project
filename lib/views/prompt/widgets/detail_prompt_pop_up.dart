import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/views/chat/new_chat_thread_view.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DetailPromptPopUpDialog extends StatefulWidget {
  //final int index;
  final Prompt prompt;
  final void Function(Prompt)? onUseInCurrentChat;


  const DetailPromptPopUpDialog({
    super.key,
    required this.prompt,
    this.onUseInCurrentChat
    //required this.index,
  });

  @override
  State<DetailPromptPopUpDialog> createState() => _DetailPromptPopUpState();
}

class _DetailPromptPopUpState extends State<DetailPromptPopUpDialog> {
  late TextEditingController _titleController;
  late TextEditingController _userNameController;
  late TextEditingController _contentController;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.prompt.title);
    _userNameController = TextEditingController(text: widget.prompt.userName);
    _contentController = TextEditingController(text: widget.prompt.content);
    _isFavorite = widget.prompt.isFavorite;
  }

  void _onUseThisPromptPressed() {
    if (widget.onUseInCurrentChat != null) {
      Navigator.of(context).pop();
      widget.onUseInCurrentChat!(widget.prompt);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            NewChatThreadView(passingPrompt: widget.prompt),
      ),
    );
  }

  void _onContentCopyPressed() {
    Clipboard.setData(ClipboardData(text: _contentController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Detail Prompt',
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
                  icon: Icon(Icons.star,
                      color: _isFavorite
                          ? Colors.yellow
                          : AppColors.quaternaryText),
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
          ),
        ],
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
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
                  enabled: false,
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: _titleController.text,
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
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text(
                    'Written by Author:',
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
                  controller: _userNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: _userNameController.text,
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
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      TouchableOpacity(
                        onTap: () => _onContentCopyPressed(),
                        child: const Icon(
                          Icons.file_copy,
                          color: AppColors.quaternaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      enabled: false,
                      controller: _contentController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: _contentController.text,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: () => _onUseThisPromptPressed(),
          icon: const Icon(Icons.chat),
          label: const Text('Use this prompt'),
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
