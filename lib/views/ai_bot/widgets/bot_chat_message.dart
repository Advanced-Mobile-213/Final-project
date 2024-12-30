import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:chatbot_agents/utils/url.dart';
import 'package:chatbot_agents/widgets/text_copy_icon.dart';

final BoxDecoration _assistantMessageDecoration = BoxDecoration(
  color: Colors.grey[800],
  borderRadius: BorderRadius.circular(15),
);

const TextStyle _messageTextStyle = TextStyle(color: Colors.white);

class BotChatMessage extends StatelessWidget {
  final String message;
  final bool canCopy;
  const BotChatMessage(this.message, this.canCopy, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.android, color: Colors.white),
        ),
        SizedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Container(
              padding: EdgeInsets.all(spacing[2]),
              decoration: _assistantMessageDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MarkdownBody(
                    data: message,
                    onTapLink: (text, href, title) async {
                      if (href != null) {
                        await openUrl(href);
                      }
                    },
                    styleSheet: MarkdownStyleSheet(
                      p: _messageTextStyle,
                      h1: _messageTextStyle,
                      h3: _messageTextStyle,
                      blockquote: _messageTextStyle,
                    ),
                  ),
                  if (canCopy) TextCopyIcon(message),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
