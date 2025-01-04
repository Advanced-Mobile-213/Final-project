import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:chatbot_agents/utils/url.dart';
import 'package:chatbot_agents/view_models/bot_configuration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/models/ai_bot/bot_configuration.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';

const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _successTextStyle = TextStyle(color: Colors.green);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.secondaryBackground.withOpacity(0.7),
  borderRadius: BorderRadius.circular(16.0),
  border: Border.all(color: Colors.white, width: 1.0),
);

class PublishedTypeList extends StatefulWidget {
  final String assistantId;
  final bool slack;
  final bool telegram;
  final bool messenger;
  const PublishedTypeList({
    super.key,
    required this.assistantId,
    required this.slack,
    required this.telegram,
    required this.messenger,
  });

  @override
  State<PublishedTypeList> createState() => _PublishedTypeListState();
}

class _PublishedTypeListState extends State<PublishedTypeList>
    with WidgetsBindingObserver {
  List<BotConfiguration>? botConfigurations;
  late final SnackBarUtil _snackBarUtil;

  Future<void> _fetchConfigurations() async {
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
      } else {
        _snackBarUtil.showError('Failed to fetch configurations');
      }
    });
  }

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

  Widget renderPublishPlatform(BotConfiguration configuration) {
    String getText(BotType type) {
      String result = '';
      switch (type) {
        case BotType.slack:
          result = 'Authorize';
          break;
        case BotType.telegram:
        case BotType.messenger:
          result = 'Open';
          break;
      }
      return result;
    }

    return (Container(
      decoration: _containerDecoration,
      padding: EdgeInsets.all(spacing[2]),
      child: Row(
        children: [
          Image.asset(botImage(configuration.type.string)),
          Gap(spacing[2]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(configuration.type.string, style: _titleTextStyle),
              const Text('Success', style: _successTextStyle)
            ],
          ),
          const Spacer(),
          TouchableOpacity(
            onTap: () => openUrl(configuration.metadata.redirect),
            child: Text(getText(configuration.type), style: _titleTextStyle),
          ),
        ],
      ),
    ));
  }

  BotConfiguration? getConfiguration(BotType way) {
    if (botConfigurations == null) return null;
    final result = botConfigurations!.where(
      (element) => element.type == way,
    );
    return result.isNotEmpty ? result.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final botConfigurationViewModel =
        context.watch<BotConfigurationViewModel>();
    final isLoading = botConfigurationViewModel.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Publishing platform', style: _titleTextStyle),
        Gap(spacing[2]),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (botConfigurations != null)
          Column(
            children: [
              if (widget.slack)
                renderPublishPlatform(getConfiguration(BotType.slack)!),
              Gap(spacing[2]),
              if (widget.telegram)
                renderPublishPlatform(getConfiguration(BotType.telegram)!),
              Gap(spacing[2]),
              if (widget.messenger)
                renderPublishPlatform(getConfiguration(BotType.messenger)!),
            ],
          ),
      ],
    );
  }
}
