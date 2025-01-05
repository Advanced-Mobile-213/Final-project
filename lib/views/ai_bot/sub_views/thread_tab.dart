import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';
import '../widgets/thread_list.dart';
import './thread_chat_view.dart';
import 'package:chatbot_agents/widgets/custom_dialog.dart';

const TextStyle _threadDescriptionHintStyle = TextStyle(color: Colors.grey);
const TextStyle _threadDescriptionStyle = TextStyle(color: Colors.white);

class ThreadTab extends StatefulWidget {
  final AiBot aiBot;
  const ThreadTab(this.aiBot, {super.key});

  @override
  State<ThreadTab> createState() => _ThreadTabState();
}

class _ThreadTabState extends State<ThreadTab> {
  late SnackBarUtil snackBarUtil;
  final TextEditingController threadDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    snackBarUtil = SnackBarUtil(context);
  }

  @override
  void dispose() {
    super.dispose();
    threadDescription.dispose();
  }

  void createThread() async {
    Navigator.of(context).pop();
    var aiBotViewModel = context.read<AiBotViewModel>();
    final newThread = await aiBotViewModel.createThread(
      assistantId: widget.aiBot.id,
      firstMessage: threadDescription.text,
    );
    threadDescription.clear();
    if (aiBotViewModel.success && newThread != null) {
      await aiBotViewModel.getThreads(assistantId: widget.aiBot.id);
      snackBarUtil.showSuccess('Thread created successfully');
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ThreadChatView(
            thread: newThread,
            aiBot: widget.aiBot,
          ),
        ),
      );
    } else {
      snackBarUtil.showError('Thread creation failed');
    }
  }

  void onCreateThreadPress() async {
    showCustomDialog(
        context,
        'Create thead',
        [
          TextField(
            controller: threadDescription,
            decoration: const InputDecoration(
              hintText: 'Enter thread description',
              hintStyle: _threadDescriptionHintStyle,
            ),
            style: _threadDescriptionStyle,
          )
        ],
        createThread);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WideButton(text: 'Create Thread', onPressed: onCreateThreadPress),
        Gap(spacing[2]),
        ThreadList(widget.aiBot),
      ],
    );
  }
}
