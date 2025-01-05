import 'package:flutter/material.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import '../widgets/user_chat_message.dart';
import '../widgets/bot_chat_message.dart';

const TextStyle _messageTextStyle = TextStyle(color: Colors.white);

class PreviewTab extends StatefulWidget {
  final AiBot aiBot;
  const PreviewTab(this.aiBot, {super.key});

  @override
  State<PreviewTab> createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;
  bool _isSending = false;
  late String _openAiThreadIdPlay;

  @override
  void initState() {
    super.initState();
    _openAiThreadIdPlay = widget.aiBot.openAiThreadIdPlay!;
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
          openAiThreadId: _openAiThreadIdPlay);
      _scrollToBottom();
      setState(() {
        _isFetching = false;
      });
    });
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
          openAiThreadId: _openAiThreadIdPlay,
        );
        messageController.clear();
        _scrollToBottom();
        setState(() {
          _isSending = false;
        });
      }
    }

    void onNewPlaygroundPress() async {
      final aiBotViewModel = context.read<AiBotViewModel>();

      setState(() {
        _isFetching = true;
      });
      String? newPlaygroundID = await aiBotViewModel
          .updateAssistantWithNewThreadPlayground(assistantId: widget.aiBot.id);
      if (newPlaygroundID != null) {
        setState(() {
          _openAiThreadIdPlay = newPlaygroundID;
        });
      }
      setState(() {
        _isFetching = false;
      });
    }

    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onNewPlaygroundPress,
            icon: const Icon(
              Icons.chat,
              color: AppColors.quaternaryBackground,
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
