import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/constants/enum_assistant_model.dart';
import 'package:chatbot_agents/models/get_conversation_history/message_mapper.dart';
import 'package:chatbot_agents/models/get_conversation_history/message_renderer_model.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/non_text_input_selection_widget.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_bottom_sheet.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_selection_widget.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';

class ChatThreadView extends StatefulWidget {
  final String conversationId;
  const ChatThreadView({
    super.key,
    required this.conversationId,
  });

  @override
  _ChatThreadViewState createState() => _ChatThreadViewState();
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class _ChatThreadViewState extends State<ChatThreadView> {
  final TextEditingController _controller = TextEditingController();
  List<MessageRendererModel> messages = [];
  bool _showPromptSelection = false;
  bool _showNonTextInputSelection = false;
  List<XFile>? _mediaFileList;
  BuildContext? _bottomSheetContext;
  late final ConversationViewModel _conversationViewModel;

  // List of bots
  final List<String> bots = EnumAssisstantId.getAllAssistantIds();
  String selectedBot = 'gpt-4o'; // Default bot

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pops the current screen from the navigation stack
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
        actions: [
          // Dropdown button to select bot
          DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            value: selectedBot,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: AppColors.secondaryBackground,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                selectedBot = newValue!;
              });
            },
            items: bots.map<DropdownMenuItem<String>>((String bot) {
              return DropdownMenuItem<String>(
                value: bot,
                child: Text(bot, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: Container(
              child: Consumer<ConversationViewModel>(
                builder: (context, ConversationViewModel conversationViewModel, child) {
                  if (conversationViewModel.isLoadingConversationHistory==true) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.quaternaryBackground,
                      ),
                    );
                  } else if (conversationViewModel.isLoadingConversationHistory==false 
                   && (conversationViewModel.listHistoryMessages == null
                   || conversationViewModel.listHistoryMessages!.items.isEmpty)) {
                    return Center(
                      child: Text('No messages found'),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUserMessage = message.isUserMessage;

                      return isUserMessage
                          ? _buildMeReply(message, screenWidth)
                          : _buildChatbotReply(message, screenWidth);
                    },
                  );
                },
              ),
            )
          ),

          // Container(
          //   padding: EdgeInsets.symmetric(

          //     horizontal: screenWidth * 0.04,
          //     vertical: screenHeight * 0.02,
          //   ),
          //   child:  (_showPromptSelection) ? PromptSelectionWidget(onPromptSelected: handlePromptSelection,) : null,

          // ),
          Center(
            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                ? FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.done:
                    return _previewImages();
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return Text(
                        'Pick image/video error: ${snapshot.error}}',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    }
                }
              },
            )
                : _previewImages(),
          ),
          // Input field to send new message
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.001, horizontal: screenWidth * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    _showNonTextInputSelectionBottomSheet();
                  },
                  icon: const Icon(
                      Icons.add_box_outlined,
                      color: AppColors.quaternaryBackground
                  ),
                ),
                Expanded(
                  child: TextInput(
                      controller: _controller,
                      hintText: "Enter message",
                      onChanged: (value){}
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),

                // Send button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed:  () async {
                    _sendMessage();
                  }
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
    );
  }

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMultiImage = false,
    bool isMedia = false,
  }) async {
    if (context.mounted) { 
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 50,
          maxHeight: 50,
          imageQuality: null,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
          if (_bottomSheetContext != null) {
            Navigator.pop(_bottomSheetContext!);
            _bottomSheetContext = null;
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    };
        
  }
  
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFileList != null) {
      final String? mime = lookupMimeType(_mediaFileList![0].path);
      return Semantics(
        label: 'image_picker_example_picked_image',
        child: kIsWeb
            ? Image.network(_mediaFileList![0].path)
            : (mime == null || mime.startsWith('image/')
                ? Image.file(
                    File(_mediaFileList![0].path),
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                          child:
                              Text('This image type is not supported'));
                    },
                  )
                : null),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      {
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            _mediaFileList = response.files;
          }
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _fetchConversationHistory() async {
    await _conversationViewModel.getConversationHistory(
                      conversationId: widget.conversationId, 
                      assistantModel: EnumAssistantModel.DIFY, 
                      assistantId: EnumAssisstantId.GPT_4O_MINI);
                    
    if (_conversationViewModel.listHistoryMessages != null && _conversationViewModel.listHistoryMessages!.items.isNotEmpty) {
      messages = MessageMapper.toMessageRendererModels(_conversationViewModel.listHistoryMessages!.items);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _conversationViewModel = context.read<ConversationViewModel>();
    _fetchConversationHistory();

  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_controller.text.endsWith('/')) {
      setState(() {
        _showPromptSelection = true;
        _showPromptSelectionBottomSheet();
      });
    } else {
      setState(() {
        _showPromptSelection = false;
        if (_bottomSheetContext != null) {
          Navigator.pop(_bottomSheetContext!);
          _bottomSheetContext = null;
        }
      });
    }
  }

  void handlePromptSelection(String prompt) {
    //_controller.text += prompt;
    setState(() {
      _showPromptSelection = false;
      if (_bottomSheetContext != null) {
        Navigator.pop(_bottomSheetContext!);
        _bottomSheetContext = null;
      }
    });
    _showDetailPromptBottomSheet(context);
  }

  void handleCloseBottomSheet(String value) {
    setState(() {
      _showPromptSelection = false;
      if (_bottomSheetContext != null) {
        Navigator.pop(_bottomSheetContext!);
        _bottomSheetContext = null;
      }
    });
  }
  
  void _showDetailPromptBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return PromptBottomSheet();
        }
    );
  }

  void _showNonTextInputSelectionBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
         _bottomSheetContext = context;
        return NonTextInputSelectionWidget(onPromptSelected: handleCloseBottomSheet, onImageButtonPressed: _onImageButtonPressed,);
      },
    ).whenComplete(() {
      _bottomSheetContext = null;
    });
  }
  
  void _showPromptSelectionBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
         _bottomSheetContext = context;
        return PromptSelectionWidget(onPromptSelected: handlePromptSelection);},
    ).whenComplete(() {
      _bottomSheetContext = null;
    });
  }
  
  Widget _buildChatbotReply(MessageRendererModel message, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chatbot Icon
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.android, color: Colors.white),
        ),
        SizedBox(width: screenWidth * 0.02),

        // Chatbot Message
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: message.icon !=null ? Icon(message.icon, color: Colors.white)
            : MarkdownBody(
              data: message.content,
              onTapLink: (text, href, title) => print('Link clicked: $href'),
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(color: Colors.white), // Change text color here
              ),
            ),          
          ),
        ),
      ],
    );
  }

  Widget _buildMeReply(MessageRendererModel message, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // User Message
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
      ],
    );
  }
   
  Widget _buildPromptSelection() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Prompt 1'),
            onTap: () {
              // Handle prompt selection
              _controller.text += 'Prompt 1';
              setState(() {
                _showPromptSelection = false;
              });
            },
          ),
          ListTile(
            title: Text('Prompt 2'),
            onTap: () {
              // Handle prompt selection
              _controller.text += 'Prompt 2';
              setState(() {
                _showPromptSelection = false;
              });
            },
          ),
          // Add more prompts as needed
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {       
        messages.insert(messages.length, 
          MessageRendererModel(
            content: _controller.text, 
            isUserMessage: true
          ),
        );

        // Simulate chatbot reply based on selected bot
        // Future.delayed(const Duration(milliseconds: 500), () {
        //   setState(() {
        //     messages.insert(messages.length, {
        //       'content': '[$selectedBot] This is a reply to: ${_controller.text}',
        //       'isUserMessage': false,
        //     });
        //   });
        // });

        messages.insert(
          messages.length, 
          MessageRendererModel(
            content: '', 
            isUserMessage: false,
            icon: FontAwesomeIcons.ellipsisH
          )
        );
      });
      String searchText = _controller.text;
      _controller.clear();
      await _conversationViewModel.sendMessage(
          assistantModel: EnumAssistantModel.DIFY, 
          assistantId: EnumAssisstantId.GPT_4O_MINI, 
          content: searchText,
          conversationId: widget.conversationId,
          files: _mediaFileList?.map((file) => file.path).toList(),
      );

      if (_conversationViewModel.messageResponseDto != null) {
        setState(() {       
          // messages.insert(messages.length, 
          //   MessageRendererModel(
          //     content: _conversationViewModel.messageResponseDto!.message,
          //     isUserMessage: false
          //   )
          // );

          messages[messages.length - 1] = MessageRendererModel(
            content: _conversationViewModel.messageResponseDto!.message,
            isUserMessage: false
          );
        });
      }

      // Clear the input field
      
    }

    if (_mediaFileList != null) {
      // Handle media file upload
      // Add media file to messages
      setState(() {
        messages.insert(
          messages.length, 
          MessageRendererModel(
            content: 'Media file uploaded', 
            isUserMessage: true
          )
        );
      });

      // Clear the media file list
      setState(() {
        _mediaFileList = null;
      });
    }
  }
}
