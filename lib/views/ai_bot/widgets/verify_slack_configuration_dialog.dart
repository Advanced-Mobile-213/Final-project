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

class VerifySlackConfigurationDialog extends StatefulWidget {
  final void Function(
    String botToken,
    String clientId,
    String clientSecret,
    String signingSecret,
  ) onConfirm;
  final String assistantId;
  const VerifySlackConfigurationDialog({
    super.key,
    required this.onConfirm,
    required this.assistantId,
  });

  @override
  VerifySlackConfigurationDialogState createState() =>
      VerifySlackConfigurationDialogState();
}

class VerifySlackConfigurationDialogState
    extends State<VerifySlackConfigurationDialog> {
  late TextEditingController botTokenController;
  late TextEditingController clientIdController;
  late TextEditingController clientSecretController;
  late TextEditingController signingSecretController;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    clientIdController = TextEditingController();
    clientSecretController = TextEditingController();
    signingSecretController = TextEditingController();
  }

  @override
  void dispose() {
    botTokenController.dispose();
    clientIdController.dispose();
    clientSecretController.dispose();
    signingSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String redirectURL =
        'https://knowledge-api.jarvis.cx/kb-core/v1/bot-integration/slack/auth/${widget.assistantId}';
    String eventRequestURL =
        'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/${widget.assistantId}';
    String slashRequestURL =
        'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/slash/${widget.assistantId}';

    return SingleChildScrollView(
      child: CustomDialog(
        title: 'Configure Slack Bot',
        onConfirm: () => widget.onConfirm(
          botTokenController.text,
          clientIdController.text,
          clientSecretController.text,
          signingSecretController.text,
        ),
        children: [
          HyperLink(
            linkCallBack: (link) => openUrl(link),
            textStyle: _textStyle,
            linkStyle: _linkStyle,
            text:
                'Connect to Slack Bots and chat with this bot in Slack App\n\n [How to obtain Slack configuration?](https://jarvis.cx/help/knowledge-base/publish-bot/slack)',
          ),
          Gap(spacing[4]),
          const TitleSection(
            sectionNumber: 1,
            title: "Slack copylink",
            subtitle:
                "Copy the following content to your Slack app configuration page.",
            canCopySubtitle: false,
          ),
          Gap(spacing[2]),
          TitleSection(title: "OAuth2 Redirect URLs", subtitle: redirectURL),
          Gap(spacing[2]),
          TitleSection(title: "Event Request URL", subtitle: eventRequestURL),
          Gap(spacing[2]),
          TitleSection(title: "Slash Request URL", subtitle: slashRequestURL),
          Gap(spacing[4]),
          const TitleSection(sectionNumber: 2, title: "Slack information"),
          Gap(spacing[2]),
          TextInput(
            controller: botTokenController,
            hintText: 'Token',
          ),
          Gap(spacing[2]),
          TextInput(
            controller: clientIdController,
            hintText: 'Client ID',
          ),
          Gap(spacing[2]),
          TextInput(
            controller: clientSecretController,
            hintText: 'Client Secret',
          ),
          Gap(spacing[2]),
          TextInput(
            controller: signingSecretController,
            hintText: 'Signing Secret',
          ),
        ],
      ),
    );
  }
}

void showVeritySlackConfigurationDialog(
  BuildContext context,
  void Function(
    String botToken,
    String clientId,
    String clientSecret,
    String signingSecret,
  ) onConfigureConfirm,
  String assistantId,
) {
  showDialog(
    context: context,
    builder: (context) => VerifySlackConfigurationDialog(
      onConfirm: onConfigureConfirm,
      assistantId: assistantId,
    ),
  );
}
