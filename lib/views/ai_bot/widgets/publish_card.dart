import 'package:chatbot_agents/models/ai_bot/bot_configuration.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'dart:developer';
import './verity_telegram_configuration_dialog.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';
import 'package:chatbot_agents/view_models/bot_configuration_view_model.dart';
import 'package:provider/provider.dart';
import 'verify_slack_configuration_dialog.dart';
import 'verify_messenger_configuration_dialog.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.secondaryBackground.withOpacity(0.7),
  borderRadius: BorderRadius.circular(16.0),
  border: Border.all(color: Colors.white, width: 1.0),
);

const TextStyle _btnTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
  decorationColor: Colors.white,
  decorationThickness: 2.0,
);

const Text _configuredText = Text(
  'Verified',
  style: TextStyle(color: Colors.green),
);

const Text _notConfiguredText = Text(
  'Not Configure',
  style: TextStyle(color: Colors.red),
);

class PublishCard extends StatefulWidget {
  final BotType name;
  final bool isChecked;
  final void Function(bool) onCheckPress;
  final BotConfiguration? configuration;
  final void Function(String botToken) onTelegramConfigureConfirm;
  final void Function(
    String botToken,
    String clientId,
    String clientSecret,
    String signingSecret,
  ) onSlackConfigurationConfirm;
  final void Function(
    String botToken,
    String pageId,
    String appSecret,
  ) onMessengerConfigurationConfirm;
  final void Function() onDisconnectPress;
  final String assistantId;

  const PublishCard({
    super.key,
    required this.name,
    required this.isChecked,
    required this.onCheckPress,
    required this.configuration,
    required this.onTelegramConfigureConfirm,
    required this.onSlackConfigurationConfirm,
    required this.onMessengerConfigurationConfirm,
    required this.onDisconnectPress,
    required this.assistantId,
  });

  @override
  State<PublishCard> createState() => _PublishCardState();
}

class _PublishCardState extends State<PublishCard> {
  late bool isConfigured;
  late final SnackBarUtil _snackBarUtil;
  late BotConfigurationViewModel botConfigurationViewModel;

  @override
  void initState() {
    super.initState();
    isConfigured = widget.configuration != null;
    _snackBarUtil = SnackBarUtil(context);
    botConfigurationViewModel = context.read<BotConfigurationViewModel>();
  }

  void onTelegramConfigureConfirm(String token) async {
    var result = await botConfigurationViewModel.verifyTelegramBotConfigure(
        botToken: token);
    if (result != null) {
      if (result == true) {
        widget.onTelegramConfigureConfirm(token);
        setState(() {
          isConfigured = true;
        });
        _snackBarUtil.showSuccess(
          'Bot configured temporarily successfully, please publish the bot to make it permanent',
        );
      } else {
        _snackBarUtil.showError('Failed to configure bot');
      }
    } else {
      _snackBarUtil.showError('Failed to configure bot');
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void onSlackConfigurationConfirm(
    String botToken,
    String clientId,
    String clientSecret,
    String signingSecret,
  ) async {
    var result = await botConfigurationViewModel.verifySlackBotConfigure(
      botToken: botToken,
      clientId: clientId,
      clientSecret: clientSecret,
      signingSecret: signingSecret,
    );
    if (result != null) {
      if (result) {
        widget.onSlackConfigurationConfirm(
          botToken,
          clientId,
          clientSecret,
          signingSecret,
        );
        setState(() {
          isConfigured = true;
        });
        _snackBarUtil.showSuccess(
          'Bot configured temporarily successfully, please publish the bot to make it permanent',
        );
      } else {
        _snackBarUtil.showError('Failed to configure bot');
      }
    } else {
      _snackBarUtil.showError('Failed to configure bot');
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void onMessengerConfigurationConfirm(
    String botToken,
    String pageId,
    String appSecret,
  ) async {
    var result = await botConfigurationViewModel.verifyMessengerBotConfigure(
      botToken: botToken,
      pageId: pageId,
      appSecret: appSecret,
    );
    if (result != null) {
      if (result) {
        widget.onMessengerConfigurationConfirm(botToken, pageId, appSecret);
        setState(() {
          isConfigured = true;
        });
        _snackBarUtil.showSuccess(
          'Bot configured temporarily successfully, please publish the bot to make it permanent',
        );
      } else {
        _snackBarUtil.showError('Failed to configure bot');
      }
    } else {
      _snackBarUtil.showError('Failed to configure bot');
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void onConfigurePress(BotType type) {
    switch (type) {
      case BotType.telegram:
        showVerityTelegramConfigurationDialog(
          context,
          onTelegramConfigureConfirm,
        );
        break;
      case BotType.slack:
        showVeritySlackConfigurationDialog(
          context,
          onSlackConfigurationConfirm,
          widget.assistantId,
        );
        break;
      case BotType.messenger:
        showVerityMessengerConfigurationDialog(
          context,
          onMessengerConfigurationConfirm,
          widget.assistantId,
        );
        break;
      default:
        log('--> Bot type not found');
    }
  }

  void onDisconnectPress(BotType type) async {
    var result = await botConfigurationViewModel.disconnectBotIntegration(
      assistantId: widget.configuration!.assistantId,
      botType: type,
    );
    if (result) {
      widget.onDisconnectPress();
      setState(() {
        isConfigured = false;
      });
      _snackBarUtil.showSuccess('Bot disconnected successfully');
    } else {
      _snackBarUtil.showError('Failed to disconnect bot');
    }
  }

  @override
  Widget build(BuildContext context) {
    String btnText;
    Text status;
    bool canBeCheck;
    void Function() onPress;

    if (widget.configuration != null) {
      status = _configuredText;
      canBeCheck = true;
      btnText = 'Disconnect';
      onPress = () => onDisconnectPress(widget.name);
    } else {
      status = _notConfiguredText;
      canBeCheck = false;
      btnText = 'Configure';
      onPress = () => onConfigurePress(widget.name);
      if (isConfigured) {
        status = _configuredText;
        canBeCheck = true;
      } else {
        status = _notConfiguredText;
        canBeCheck = false;
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, spacing[2], spacing[2], spacing[2]),
      decoration: _containerDecoration,
      child: Row(
        children: [
          if (canBeCheck)
            Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) => widget.onCheckPress(value!),
            )
          else
            Gap(spacing[6]),
          Image.asset(botImage(widget.name.string)),
          Gap(spacing[2]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name.string, style: _titleTextStyle),
              status,
            ],
          ),
          const Spacer(),
          TouchableOpacity(
            onTap: onPress,
            child: Text(btnText, style: _btnTextStyle),
          ),
        ],
      ),
    );
  }
}
