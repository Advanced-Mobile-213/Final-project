import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/custom_dialog.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:chatbot_agents/utils/url.dart';

const TextStyle _textStyle =
    TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
const TextStyle _linkStyle =
    TextStyle(color: AppColors.hyperlinkText, fontSize: 15);

class VerityTelegramConfigurationDialog extends StatefulWidget {
  final void Function(String token) onConfirm;
  const VerityTelegramConfigurationDialog({super.key, required this.onConfirm});

  @override
  VerityTelegramConfigurationDialogState createState() =>
      VerityTelegramConfigurationDialogState();
}

class VerityTelegramConfigurationDialogState
    extends State<VerityTelegramConfigurationDialog> {
  late TextEditingController botTokenController;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
  }

  @override
  void dispose() {
    botTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Configure Telegram Bot',
      onConfirm: () => widget.onConfirm(botTokenController.text),
      children: [
        HyperLink(
          linkCallBack: (link) => openUrl(link),
          textStyle: _textStyle,
          linkStyle: _linkStyle,
          text:
              'Connect to Telegram Bots and chat with this bot in Telegram App\n\n [How to obtain Telegram configuration?](https://jarvis.cx/help/knowledge-base/publish-bot/telegram)',
        ),
        Gap(spacing[4]),
        TextInput(
          controller: botTokenController,
          hintText: 'Token',
        ),
      ],
    );
  }
}

void showVerityTelegramConfigurationDialog(
    BuildContext context, void Function(String token) onConfigureConfirm) {
  showDialog(
    context: context,
    builder: (context) =>
        VerityTelegramConfigurationDialog(onConfirm: onConfigureConfirm),
  );
}
