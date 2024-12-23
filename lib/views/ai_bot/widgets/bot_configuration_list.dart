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

class TelegramConfiguration {
  String? botToken;
  TelegramConfiguration({this.botToken});
}

class SlackConfiguration {
  String? botToken;
  String? clientId;
  String? clientSecret;
  String? signingSecret;
  SlackConfiguration({
    this.botToken,
    this.clientId,
    this.clientSecret,
    this.signingSecret,
  });
}

class MessengerConfiguration {
  String? botToken;
  String? pageId;
  String? appSecret;
  MessengerConfiguration({
    this.botToken,
    this.pageId,
    this.appSecret,
  });
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
    BotType.slack: SlackConfiguration(),
    BotType.telegram: TelegramConfiguration(),
    BotType.messenger: MessengerConfiguration(),
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
    _publishItems.forEach((key, value) {
      _publishItems[key] = false;
    });
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
        if (getConfiguration(BotType.slack) != null) {
          _configurations[BotType.slack] = SlackConfiguration(
            botToken: getConfiguration(BotType.slack)?.metadata.botToken,
            clientId: getConfiguration(BotType.slack)?.metadata.clientId,
            clientSecret:
                getConfiguration(BotType.slack)?.metadata.clientSecret,
            signingSecret:
                getConfiguration(BotType.slack)?.metadata.signingSecret,
          );
        }
        if (getConfiguration(BotType.messenger) != null) {
          _configurations[BotType.messenger] = MessengerConfiguration(
            botToken: getConfiguration(BotType.messenger)?.metadata.botToken,
            pageId: getConfiguration(BotType.messenger)?.metadata.pageId,
            appSecret: getConfiguration(BotType.messenger)?.metadata.appSecret,
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

  void onSlackConfigurePress(
    String botToken,
    String clientId,
    String clientSecret,
    String signingSecret,
  ) {
    setState(() {
      _configurations[BotType.slack] = SlackConfiguration(
        botToken: botToken,
        clientId: clientId,
        clientSecret: clientSecret,
        signingSecret: signingSecret,
      );
    });
  }

  void onMessengerConfigurePress(
    String botToken,
    String pageId,
    String appSecret,
  ) {
    setState(() {
      _configurations[BotType.messenger] = MessengerConfiguration(
        botToken: botToken,
        pageId: pageId,
        appSecret: appSecret,
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
      if (_publishItems[BotType.slack] == true) {
        result = await botConfigurationViewModel.publishSlackBot(
          assistantId: widget.assistantId,
          botToken: _configurations[BotType.slack].botToken,
          clientId: _configurations[BotType.slack].clientId,
          clientSecret: _configurations[BotType.slack].clientSecret,
          signingSecret: _configurations[BotType.slack].signingSecret,
        );
      }
      if (_publishItems[BotType.messenger] == true) {
        result = await botConfigurationViewModel.publishMessengerBot(
          assistantId: widget.assistantId,
          botToken: _configurations[BotType.messenger].botToken,
          pageId: _configurations[BotType.messenger].pageId,
          appSecret: _configurations[BotType.messenger].appSecret,
        );
      }
      if (result != null) {
        await _fetchConfigurations();

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AiBotSuccessPublishView(
                assistantId: widget.assistantId,
                slack: _publishItems[BotType.slack]!,
                telegram: _publishItems[BotType.telegram]!,
                messenger: _publishItems[BotType.messenger]!,
              ),
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
              onSlackConfigurationConfirm: onSlackConfigurePress,
              onMessengerConfigurationConfirm: onMessengerConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
              assistantId: widget.assistantId,
            ),
            Gap(spacing[3]),
            PublishCard(
              name: BotType.telegram,
              isChecked: _publishItems[BotType.telegram]!,
              onCheckPress: (bool value) =>
                  _toggleConfigStatus(BotType.telegram),
              configuration: getConfiguration(BotType.telegram),
              onTelegramConfigureConfirm: onTelegramConfigurePress,
              onSlackConfigurationConfirm: onSlackConfigurePress,
              onMessengerConfigurationConfirm: onMessengerConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
              assistantId: widget.assistantId,
            ),
            Gap(spacing[3]),
            PublishCard(
              name: BotType.messenger,
              isChecked: _publishItems[BotType.messenger]!,
              onCheckPress: (bool value) =>
                  _toggleConfigStatus(BotType.messenger),
              configuration: getConfiguration(BotType.messenger),
              onTelegramConfigureConfirm: onTelegramConfigurePress,
              onSlackConfigurationConfirm: onSlackConfigurePress,
              onMessengerConfigurationConfirm: onMessengerConfigurePress,
              onDisconnectPress: () => _fetchConfigurations(),
              assistantId: widget.assistantId,
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
