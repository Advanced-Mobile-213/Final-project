import 'package:flutter/material.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/models/ai_bot/chat_thread.dart';
import '../widgets/user_chat_message.dart';
import '../widgets/bot_chat_message.dart';

const TextStyle _messageTextStyle = TextStyle(color: Colors.white);

class ThreadChatView extends StatefulWidget {
  final ChatThread thread;
  final AiBot aiBot;
  const ThreadChatView({super.key, required this.thread, required this.aiBot});

  @override
  State<ThreadChatView> createState() => _ThreadChatViewState();
}

class _ThreadChatViewState extends State<ThreadChatView>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchMessages();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _fetchMessages() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isFetching = true;
      });
      final aiBotViewModel = context.read<AiBotViewModel>();
      await aiBotViewModel.retrieveMessageOfThread(
          openAiThreadId: widget.thread.openAiThreadId);
      _scrollToBottom();
      setState(() {
        _isFetching = false;
      });
    });
  }

  Widget _buildChatInput() {
    final TextEditingController messageController = TextEditingController();
    final aiBotViewModel = context.watch<AiBotViewModel>();

    void onSendPress() async {
      final message = messageController.text;
      if (message.isNotEmpty) {
        setState(() {
          _isSending = true;
        });
        await aiBotViewModel.askAssistant(
          assistantId: widget.aiBot.id,
          message: message,
          openAiThreadId: widget.thread.openAiThreadId,
        );
        messageController.clear();
        _scrollToBottom();
        setState(() {
          _isSending = false;
        });
      }
    }

    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              style: _messageTextStyle,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: onSendPress,
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    final aiBotViewModel = context.watch<AiBotViewModel>();

    if (_isFetching) {
      return const Center(child: CircularProgressIndicator());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return ListView.separated(
      controller: _scrollController,
      itemCount: aiBotViewModel.messages.length + (_isSending ? 1 : 0),
      separatorBuilder: (context, index) => Gap(spacing[2]),
      itemBuilder: (context, index) {
        Widget messageWidget;
        if (index == aiBotViewModel.messages.length) {
          messageWidget = const BotChatMessage('...', false);
        } else {
          final message = aiBotViewModel.messages[index];
          if (message.role == 'assistant') {
            messageWidget = BotChatMessage(message.message, true);
          } else {
            messageWidget = UserChatMessage(message.message);
          }
        }
        return messageWidget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: widget.thread.threadName,
      canGoBack: true,
      children: [
        Expanded(
          child: _buildChatList(),
        ),
        SizedBox(
          height: 80,
          child: _buildChatInput(),
        ),
      ],
    );
  }
}
