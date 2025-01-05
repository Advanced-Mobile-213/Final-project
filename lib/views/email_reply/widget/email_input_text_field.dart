import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EmailInputTextField extends StatefulWidget{
  final String title;
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int maxLines;

  const EmailInputTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.minLines,
    required this.maxLines,
  }) : super(key: key);

  @override
  _EmailInputTextFieldState createState() => _EmailInputTextFieldState();
}

class _EmailInputTextFieldState extends State<EmailInputTextField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late int _minLines;
  late int _maxLines;
  late String _hintText;
  late String _title;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _minLines = widget.minLines;
    _maxLines = widget.maxLines;
    _hintText = widget.hintText;
    _title = widget.title;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Move the cursor to the beginning when the TextField loses focus
        _controller.selection = TextSelection.fromPosition(const TextPosition(offset: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Text(_title,
            style: const TextStyle(
              color: AppColors.quaternaryText,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextField(
            controller: _controller,
            minLines: _minLines,
            maxLines: _maxLines,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              color: AppColors.quaternaryText,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryBackground,
              hintText: _hintText,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: const TextStyle(
                color: AppColors.greyText,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.secondaryBackground,
                  width: 4.0,
                ),
              ),
            ),
            onSubmitted: (value) {
            },
          ),
        ],
      )
  );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}