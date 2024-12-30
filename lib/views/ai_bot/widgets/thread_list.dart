import 'package:flutter/material.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'thread_list_item.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';

const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class ThreadList extends StatefulWidget {
  final AiBot aiBot;

  const ThreadList(this.aiBot, {super.key});

  @override
  State<ThreadList> createState() => _ThreadListState();
}

class _ThreadListState extends State<ThreadList> with WidgetsBindingObserver {
  void fetchThreads() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final aiBotViewModel = context.read<AiBotViewModel>();
      await aiBotViewModel.getThreads(assistantId: widget.aiBot.id);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchThreads();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchThreads();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiBotViewModel = context.watch<AiBotViewModel>();
    Widget content;

    if (aiBotViewModel.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (aiBotViewModel.threads.isEmpty) {
      content = const Center(
        child: Text('No threads found', style: _emptyTextStyle),
      );
    } else {
      content = ListView.separated(
          itemBuilder: (context, index) =>
              ThreadListItem(thread: aiBotViewModel.threads[index], aiBot: widget.aiBot,),
          separatorBuilder: (context, index) => Gap(spacing[1]),
          itemCount: aiBotViewModel.threads.length);
    }

    return Expanded(child: content);
  }
}
