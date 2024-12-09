import 'package:chatbot_agents/models/ai_bot/bot_configuration.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import './publish_card.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:chatbot_agents/view_models/bot_configuration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';
import '../ai_bot_success_publish_view.dart';
//import 'dart:developer';

class TelegramConfiguration {
  String? botToken;
  TelegramConfiguration({this.botToken});
}

class BotConfigurationList extends StatefulWidget {
  final String assistantId;
  const BotConfigurationList(this.assistantId, {super.key});

  @override
  State<BotConfigurationList> createState() => _BotConfigurationListState();
}

class _BotConfigurationListState extends State<BotConfigurationList>
    with WidgetsBindingObserver {
  late final SnackBarUtil _snackBarUtil;

  final Map<BotType, bool> _publishItems = {
    BotType.slack: false,
    BotType.telegram: false,
    BotType.messenger: false,
  };
  List<BotConfiguration>? botConfigurations;
  bool isLoading = false;
  final Map<BotType, dynamic> _configurations = {
    BotType.slack: null,
    BotType.telegram: TelegramConfiguration(),
    BotType.messenger: null,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _snackBarUtil = SnackBarUtil(context);
    _fetchConfigurations();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchConfigurations();
    }
  }

  Future<void> _fetchConfigurations() async {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final botConfigurationViewModel =
          context.read<BotConfigurationViewModel>();
      var result = await botConfigurationViewModel.getConfigurations(
        assistantId: widget.assistantId,
      );
      if (result != null) {
        setState(() {
          botConfigurations = result;
        });
        if (getConfiguration(BotType.telegram) != null) {
          _configurations[BotType.telegram] = TelegramConfiguration(
            botToken: getConfiguration(BotType.telegram)?.metadata.botToken,
          );
        }
      } else {
        _snackBarUtil.showError('Failed to fetch configurations');
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  BotConfiguration? getConfiguration(BotType way) {
    if (botConfigurations == null) return null;
    final result = botConfigurations!.where(
      (element) => element.type == way,
    );
    return result.isNotEmpty ? result.first : null;
  }

  void _toggleConfigStatus(BotType way) {
    setState(() {
      _publishItems[way] = !_publishItems[way]!;
    });
  }

  void onTelegramConfigurePress(String token) {
    setState(() {
      _configurations[BotType.telegram] = TelegramConfiguration(
        botToken: token,
      );
    });
  }

  void onPublishPress() async {
    if (_publishItems.values.every((element) => !element)) {
      _snackBarUtil.showError('Please select at least one bot to publish');
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      final botConfigurationViewModel =
          context.read<BotConfigurationViewModel>();
      String? result;
      if (_publishItems[BotType.telegram] == true) {
        result = await botConfigurationViewModel.publishTelegramBot(
          assistantId: widget.assistantId,
          botToken: _configurations[BotType.telegram].botToken,
        );
      }
      if (result != null) {
        await _fetchConfigurations();
        _publishItems.forEach((key, value) {
          _publishItems[key] = false;
        });
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AiBotSuccessPublishView(widget.assistantId),
            ),
          );
        }
      } else {
        _snackBarUtil.showError('Failed to publish bot');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PublishCard(
              name: BotType.slack,
              isChecked: _publishItems[BotType.slack]!,
              onCheckPress: (bool value) => _toggleConfigStatus(BotType.slack),
              configuration: getConfiguration(BotType.slack),
              onTelegramConfigureConfirm: onTelegramConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
            ),
            Gap(spacing[3]),
            PublishCard(
              name: BotType.telegram,
              isChecked: _publishItems[BotType.telegram]!,
              onCheckPress: (bool value) =>
                  _toggleConfigStatus(BotType.telegram),
              configuration: getConfiguration(BotType.telegram),
              onTelegramConfigureConfirm: onTelegramConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
            ),
            Gap(spacing[3]),
            PublishCard(
              name: BotType.messenger,
              isChecked: _publishItems[BotType.messenger]!,
              onCheckPress: (bool value) =>
                  _toggleConfigStatus(BotType.messenger),
              configuration: getConfiguration(BotType.messenger),
              onTelegramConfigureConfirm: onTelegramConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
            ),
            Gap(spacing[4]),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              WideButton(text: 'Publish', onPressed: onPublishPress),
          ],
        ),
      ),
    );
  }
}
