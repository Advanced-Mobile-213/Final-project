import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class TextCopyIcon extends StatelessWidget {
  final String text;

  const TextCopyIcon(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    void onCopy() {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard')),
      );
    }

    return IconButton(
      icon: const Icon(Icons.copy, color: AppColors.hyperlinkText),
      onPressed: onCopy,
    );
  }
}
