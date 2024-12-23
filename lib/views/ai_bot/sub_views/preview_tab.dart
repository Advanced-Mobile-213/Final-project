import 'package:flutter/material.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:chatbot_agents/utils/url.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';
import 'package:chatbot_agents/widgets/text_copy_icon.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

final BoxDecoration _userMessageDecoration = BoxDecoration(
  color: Colors.blue[400],
  borderRadius: BorderRadius.circular(15),
);

final BoxDecoration _assistantMessageDecoration = BoxDecoration(
  color: Colors.grey[800],
  borderRadius: BorderRadius.circular(15),
);

const TextStyle _messageTextStyle = TextStyle(color: Colors.white);

class PreviewTab extends StatefulWidget {
  final AiBot aiBot;
  const PreviewTab(this.aiBot, {super.key});

  @override
  State<PreviewTab> createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> with WidgetsBindingObserver {
  late SnackBarUtil snackBarUtil;
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;
  bool _isSending = false;
  late String _openAiThreadIdPlay;

  @override
  void initState() {
    super.initState();
    _openAiThreadIdPlay = widget.aiBot.openAiThreadIdPlay!;
    WidgetsBinding.instance.addObserver(this);
    snackBarUtil = SnackBarUtil(context);
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

  Widget _buildUserMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(spacing[2]),
            decoration: _userMessageDecoration,
            child: Text(
              message,
              textDirection: TextDirection.ltr,
              maxLines: null,
              style: _messageTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssistantReply(String message, bool canCopy) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.android, color: Colors.white),
        ),
        SizedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Container(
              padding: EdgeInsets.all(spacing[2]),
              decoration: _assistantMessageDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarkdownBody(
                    data: message,
                    onTapLink: (text, href, title) async {
                      if (href != null) {
                        await openUrl(href);
                      }
                    },
                    styleSheet: MarkdownStyleSheet(
                      p: _messageTextStyle,
                      h1: _messageTextStyle,
                      h3: _messageTextStyle,
                      blockquote: _messageTextStyle,
                    ),
                  ),
                  if (canCopy) TextCopyIcon(message),
                ],
              ),
            ),
          ),
        )
      ],
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
      itemCount: aiBotViewModel.previewMessages.length + (_isSending ? 1 : 0),
      separatorBuilder: (context, index) => Gap(spacing[2]),
      itemBuilder: (context, index) {
        if (index == aiBotViewModel.previewMessages.length) {
          return _buildAssistantReply('...', false);
        }

        final message = aiBotViewModel.previewMessages[index];
        if (message.role == 'assistant') {
          return _buildAssistantReply(message.message, true);
        } else {
          return _buildUserMessage(message.message);
        }
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
