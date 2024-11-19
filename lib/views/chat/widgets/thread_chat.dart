import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/views/chat/chat_thread_view.dart';
import 'package:flutter/material.dart';

class ThreadChat extends StatefulWidget {
  final String conversationId;
  final String conversationTitle;
  final int createdAt;

  const ThreadChat({
    Key? key, 
    required this.conversationId, 
    required this.conversationTitle, 
    required this.createdAt
  }) : super(key: key);

  @override
  State<ThreadChat> createState() => _ThreadChatState();

}

class _ThreadChatState extends State<ThreadChat> {
  late final String _coversationId;

  @override
  void initState() {
    super.initState();
    _coversationId = widget.conversationId;
  }

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:  (context) => ChatThreadView(
              conversationId: _coversationId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.conversationTitle, 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(widget.createdAt * 1000).toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {

                     }
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed:  () {
                        
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}