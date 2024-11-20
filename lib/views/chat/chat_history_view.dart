import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/constants/enum_assistant_model.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/views/chat/chat_thread_view.dart';
import 'package:chatbot_agents/views/chat/widgets/thread_chat.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryView extends StatefulWidget {
  const ChatHistoryView({super.key});

  @override
  State<ChatHistoryView> createState() => _ChatHistoryViewState();
}

class _ChatHistoryViewState extends State<ChatHistoryView> {
  late final ListConversationsViewModel listConversationsViewModel;
  bool _isCreatingThread = false;
  
  @override
  void initState() {
    super.initState();
    listConversationsViewModel = context.read<ListConversationsViewModel>();
    _fetchListConversations();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenHeight * 0.05; // Adjust icon size based on screen height

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic, // Ensures proper alignment
                            children: [
                              const Text(
                                'Chat History',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 5), // Space between title and number of threads
                              Consumer<ListConversationsViewModel>(
                                builder: (context, ListConversationsViewModel listConversationsViewModel, child) {
                                return Text(
                                  '(${listConversationsViewModel.conversations?.items.length ?? 0})', // Number of chat threads
                                  style: TextStyle(
                                    color: Colors.grey[400], // Lighter text for the count
                                    fontSize: 16,
                                  ),
                                );
                              }),
                              
                            ],
                          ),
                        ),

                        // Search Bar
                        SearchInput(onChanged: (value) {}),
                        const SizedBox(height: 16),

                        // Chat Threads
                        Expanded(
                          child: Container(
                            //scrollDirection: Axis.vertical,
                            child: Consumer<ListConversationsViewModel>(
                              builder: (context, ListConversationsViewModel listConversationsViewModel, child) {
                                if (listConversationsViewModel.isLoading==true) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (listConversationsViewModel.isLoading==false 
                                && (listConversationsViewModel.conversations == null 
                                || (listConversationsViewModel.conversations?.items.isEmpty ?? true))) {
                                  return const Center(
                                    child: Text(
                                      'No chat threads found',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: listConversationsViewModel.conversations?.items.length ?? 0,
                                  itemBuilder: (BuildContext context, int index) {
                                    final conversation = listConversationsViewModel.conversations?.items[index];
                                    return ThreadChat(
                                      conversationTitle: conversation?.title ?? '',
                                      createdAt: conversation?.createdAt ?? 0,
                                      conversationId: conversation?.id ?? '',
                                    );
                                  }
                                );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isCreatingThread)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: ModalBarrier(
                dismissible: false, 
                color: Colors.black
              ),
            ),

          if (_isCreatingThread)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
      // Floating Action Button to create new chat thread
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewThreadDialog(context),
        backgroundColor: AppColors.secondaryBackground,
        child: const Icon(
          Icons.add,
          color: AppColors.quaternaryText,
        ),
      ),
    );
  }

 void _fetchListConversations() async {
    await listConversationsViewModel.getConversations(
      assistantModel: EnumAssistantModel.DIFY, 
      assistantId: EnumAssisstantId.GPT_4O_MINI
    );
  }
  
  void _createNewThreadDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.dialogBackground,
          title: const Text(
            'Start a new conversation',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: TextField(
              style: TextStyle(color: Colors.white),
              controller: titleController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter what you want to ask...',
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(10), // Add border radius here
                  borderSide: BorderSide(
                      color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Add border radius for focused state
                  borderSide: BorderSide(
                      color: Colors.white), // Change color when focused
                ),
              )),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without doing anything
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                
                // setState(() {
                //   _isCreatingThread = true;
                // });

                await listConversationsViewModel.createConversation(
                  assistantModel: EnumAssistantModel.DIFY,
                  assistantId: EnumAssisstantId.GPT_4O_MINI,
                  //assistantName: titleController.text, 
                  content: titleController.text,
                );

                Navigator.of(context).pop(); // Close the dialog

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:  (context) => ChatThreadView(
                      conversationId: listConversationsViewModel
                          .messageResponseDto!.conversationId,
                    ),
                  ),
                );

              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
  
}
