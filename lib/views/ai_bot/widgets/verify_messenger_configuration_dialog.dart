import 'package:chatbot_agents/views/ai_bot/widgets/title_section.dart';
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

class VerifyMessengerConfigurationDialog extends StatefulWidget {
  final void Function(String token, String pageId, String appSecret) onConfirm;
  final String assistantId;
  const VerifyMessengerConfigurationDialog({
    super.key,
    required this.onConfirm,
    required this.assistantId,
  });

  @override
  VerifyMessengerConfigurationDialogState createState() =>
      VerifyMessengerConfigurationDialogState();
}

class VerifyMessengerConfigurationDialogState
    extends State<VerifyMessengerConfigurationDialog> {
  late TextEditingController botTokenController;
  late TextEditingController botPageIdController;
  late TextEditingController botAppSecretController;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    botPageIdController = TextEditingController();
    botAppSecretController = TextEditingController();
  }

  @override
  void dispose() {
    botTokenController.dispose();
    botPageIdController.dispose();
    botAppSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String callBackURL =
        'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/${widget.assistantId}';

    return SingleChildScrollView(
      child: CustomDialog(
        title: 'Configure Messenger Bot',
        onConfirm: () => widget.onConfirm(
          botTokenController.text,
          botPageIdController.text,
          botAppSecretController.text,
        ),
        children: [
          HyperLink(
            linkCallBack: (link) => openUrl(link),
            textStyle: _textStyle,
            linkStyle: _linkStyle,
            text:
                'Connect to Messenger Bots and chat with this bot in Messenger App\n\n [How to obtain Messenger configuration?](https://jarvis.cx/help/knowledge-base/publish-bot/messenger)',
          ),
          Gap(spacing[4]),
          const TitleSection(
            sectionNumber: 1,
            title: "Messenger copylink",
            subtitle:
                "Copy the following content to your Messenger app configuration page.",
            canCopySubtitle: false,
          ),
          Gap(spacing[2]),
          TitleSection(title: "Callback URL", subtitle: callBackURL),
          Gap(spacing[2]),
          const TitleSection(title: "Verify Token", subtitle: 'knowledge'),
          Gap(spacing[4]),
          const TitleSection(sectionNumber: 2, title: "Messenger information"),
          Gap(spacing[2]),
          TextInput(
            controller: botTokenController,
            hintText: 'Messenger Bot Token',
          ),
          Gap(spacing[2]),
          TextInput(
            controller: botPageIdController,
            hintText: 'Messenger Bot Page ID',
          ),
          Gap(spacing[2]),
          TextInput(
            controller: botAppSecretController,
            hintText: 'Messenger Bot App Secret',
          ),
        ],
      ),
    );
  }
}

void showVerityMessengerConfigurationDialog(
  BuildContext context,
  void Function(String token, String pageId, String appSecret)
      onConfigureConfirm,
  String assistantId,
) {
  showDialog(
    context: context,
    builder: (context) => VerifyMessengerConfigurationDialog(
      onConfirm: onConfigureConfirm,
      assistantId: assistantId,
    ),
  );
}
