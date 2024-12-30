import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';

final BoxDecoration _userMessageDecoration = BoxDecoration(
  color: Colors.blue[400],
  borderRadius: BorderRadius.circular(15),
);

const TextStyle _messageTextStyle = TextStyle(color: Colors.white);

class UserChatMessage extends StatelessWidget {
  final String message;
  const UserChatMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: spacing[5]),
            padding: EdgeInsets.all(spacing[2]),
            decoration: _userMessageDecoration,
            child: Text(
              message,
              textDirection: TextDirection.ltr,
              maxLines: null,
              style: _messageTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}