import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:chatbot_agents/models/ai_bot/chat_thread.dart';
import 'package:intl/intl.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import '../sub_views/thread_chat_view.dart';

DateFormat formatter = DateFormat('HH:mm:ss | yyyy-MM-dd');

const _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const _dateStyle = TextStyle(
  color: Colors.grey,
  fontSize: 12,
);

class ThreadListItem extends StatelessWidget {
  final ChatThread thread;
  final AiBot aiBot;
  const ThreadListItem({super.key, required this.thread, required this.aiBot});

  @override
  Widget build(BuildContext context) {
    void onPress() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ThreadChatView(thread: thread, aiBot: aiBot),
        ),
      );
    }

    return TouchableOpacity(
      onTap: () => onPress(),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing[2]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thread.threadName, style: _titleStyle),
                    Gap(spacing[1]),
                    Text(
                      formatter.format(thread.createdAt.toLocal()),
                      style: _dateStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
