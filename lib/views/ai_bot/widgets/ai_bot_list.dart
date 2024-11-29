import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import 'ai_bot_list_item.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
//import 'dart:developer';

const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class AiBotList extends StatefulWidget {
  final String searchingText;

  const AiBotList(this.searchingText, {super.key});

  @override
  State<AiBotList> createState() => _AiBotListState();
}

class _AiBotListState extends State<AiBotList> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchAssistants();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchAssistants();
    }
  }

  @override
  void didUpdateWidget(AiBotList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchingText != widget.searchingText) {
      _fetchAssistants();
    }
  }

  Future<void> _fetchAssistants() async {
    final aiBotViewModel = context.read<AiBotViewModel>();
    await aiBotViewModel.getAssistants(q: widget.searchingText);
  }

  void onDeleteAiBotPressed(String id) async {
    final aiBotViewModel = context.read<AiBotViewModel>();
    await aiBotViewModel.deleteAssistant(assistantId: id);
  }

  @override
  Widget build(BuildContext context) {
    final aiBotViewModel = context.watch<AiBotViewModel>();

    final Widget content;
    if (aiBotViewModel.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      if (aiBotViewModel.aiBots.isEmpty) {
        content = const Center(
            child: Text('No AI Bot found', style: _emptyTextStyle));
      } else {
        final filteredAIBots = aiBotViewModel.aiBots;
        content = ListView.separated(
          itemCount: filteredAIBots.length,
          separatorBuilder: (context, index) => Gap(spacing[2]),
          itemBuilder: (context, index) => AiBotListItem(
            filteredAIBots[index],
            (aibot) => onDeleteAiBotPressed(aibot.id),
          ),
        );
      }
    }

    return Expanded(child: content);
  }
}
