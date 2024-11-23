import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/constants/enum_assistant_model.dart';
import 'package:chatbot_agents/mapper/message_mapper.dart';
import 'package:chatbot_agents/models/get_conversation_history/message_renderer_model.dart';
import 'package:chatbot_agents/utils/function/prompt_util.dart';
import 'package:chatbot_agents/utils/string_utils.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/non_text_input_selection_widget.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_bottom_sheet.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_selection_widget.dart';
import 'package:chatbot_agents/widgets/text_input.dart' as CustomizedTextInput;
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chatbot_agents/models/models.dart';

class NewChatThreadView extends StatefulWidget {
  final Prompt? passingPrompt;
  const NewChatThreadView({super.key, this.passingPrompt});

  @override
  _NewChatThreadViewState createState() => _NewChatThreadViewState();
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class _NewChatThreadViewState extends State<NewChatThreadView> {
  final TextEditingController _controller = TextEditingController();
  List<MessageRendererModel> messages = [];
  bool _showPromptSelection = false;
  bool _showNonTextInputSelection = false;
  List<XFile>? _mediaFileList;
  BuildContext? _bottomSheetContext;
  final ScrollController _scrollController = ScrollController();
  late final ConversationViewModel _conversationViewModel;
  late final ListConversationsViewModel _listConversationsViewModel;
  // List of bots
  final List<String> bots = EnumAssisstantId.getAllAssistantIds();
  String selectedBot = 'gpt-4o-mini'; // Default bot
  final List<int> costToken = [1, 3, 1, 5, 5, 1];

  late String _conversationId = '';



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.passingPrompt != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        PromptUtil.showDynamicInput(context, widget.passingPrompt!, _controller);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Back arrow icon
          onPressed: () {
            _conversationViewModel.clearContextOfConversation();
            _listConversationsViewModel.getConversations(
              assistantModel: EnumAssistantModel.DIFY,
              assistantId: EnumAssisstantId.GPT_4O_MINI,
            );
            Navigator.pop(
                context); // Pops the current screen from the navigation stack
          },
        ),
        // title: IconButton(
        //   onPressed: () async {
        //     _fetchMoreConversationHistory();
        //   },
        //   icon: Icon(Icons.replay_outlined, color: Colors.white)
        // ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
        actions: [
          // Dropdown button to select bot
          Container(
            child: DropdownButton<String>(
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
                  child: Text(
                    '$bot : ${costToken[bots.indexOf(bot)]} tokens',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 15,
                ),
                // const Text('Tokens: ',
                //   style: TextStyle(color: Colors.white),
                // ),
                Text(
                  _conversationViewModel.messageResponseDto?.remainingUsage !=
                          null
                      ? _conversationViewModel
                          .messageResponseDto!.remainingUsage
                          .toString()
                      : _conversationViewModel.remainingToken != 0
                          ? _conversationViewModel.remainingToken.toString()
                          : '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(child: Container(
            child: Consumer<ConversationViewModel>(
              builder: (context, ConversationViewModel conversationViewModel,
                  child) {
                if (messages.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(5.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUserMessage = message.isUserMessage;

                      return isUserMessage
                          ? _buildMeReply(message, screenWidth)
                          : _buildChatbotReply(message, screenWidth);
                    },
                  );
                } else if (conversationViewModel.isLoadingConversationHistory ==
                        false &&
                    (conversationViewModel.messages == null ||
                        conversationViewModel.messages!.messages.isEmpty)) {
                  return Center(
                    child: Container(),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottomAnimated();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(5.0),
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
          )),

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
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                  onPressed: () {
                    _showNonTextInputSelectionBottomSheet();
                  },
                  icon: const Icon(Icons.add_box_outlined,
                      color: AppColors.quaternaryBackground),
                ),
                Expanded(
                  child: CustomizedTextInput.TextInput(
                      controller: _controller,
                      hintText: "Enter message",
                      onChanged: (value) {}),
                ),
                SizedBox(width: screenWidth * 0.02),

                // Send button
                IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      _sendMessage();
                    }),
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
    }
    ;
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
                          child: Text('This image type is not supported'));
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
    if (_conversationViewModel.listHistoryMessages != null &&
        _conversationViewModel.listHistoryMessages!.items.isNotEmpty) {
      messages = MessageMapper.toMessageRendererModels(
          _conversationViewModel.listHistoryMessages!.items);
    }
  }

  void _fetchRemainingToken() async {
    await _conversationViewModel.getRemainingToken();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _conversationViewModel = context.read<ConversationViewModel>();
    _listConversationsViewModel = context.read<ListConversationsViewModel>();
    _fetchRemainingToken();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToBottom();
    // });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollToBottomAnimated() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _scrollController.dispose();
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
        });
  }

  void _showNonTextInputSelectionBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        _bottomSheetContext = context;
        return NonTextInputSelectionWidget(
          onPromptSelected: handleCloseBottomSheet,
          onImageButtonPressed: _onImageButtonPressed,
        );
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
        return PromptSelectionWidget(onPromptSelected: handlePromptSelection, textSendController: _controller,);
      },
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
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                message.icon != null
                    ? Icon(message.icon, color: Colors.white)
                    : MarkdownBody(
                        data: message.content,
                        onTapLink: (text, href, title) async {
                          if (href != null) {
                            print('Link clicked: $href');
                            if (await canLaunchUrl(Uri.parse(href))) {
                              await launchUrl(Uri.parse(href));
                            } else {
                              print('Could not launch $href');
                            }
                          }
                        },
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                              color: Colors.white), // Change text color here
                          h1: TextStyle(color: Colors.white),
                          h3: TextStyle(color: Colors.white),
                          blockquote: TextStyle(color: Colors.white),
                        ),
                      ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: message.content));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard')),
                      );
                    },
                  ),
                ),
              ],
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
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth *
                  0.7, // Limit the width to 70% of the screen width
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                textDirection: TextDirection.ltr,
                message.content,
                maxLines: null,
                style: TextStyle(color: Colors.white),
              ),
            ),
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
        messages.insert(
          messages.length,
          MessageRendererModel(content: _controller.text, isUserMessage: true),
        );

        messages.insert(
            messages.length,
            MessageRendererModel(
                content: '',
                isUserMessage: false,
                icon: FontAwesomeIcons.ellipsisH));
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottomAnimated();
      });

      String searchText = _controller.text;
      _controller.clear();

      print('_conversationId: ${_conversationId}');

      await _conversationViewModel.sendMessage(
        assistantModel: EnumAssistantModel.DIFY,
        assistantId: selectedBot,
        content: searchText,
        conversationId: _conversationId,
        files: _mediaFileList?.map((file) => file.path).toList(),
      );

      print(
          '_conversationViewModel.messageResponseDto: ${_conversationViewModel.messageResponseDto}');

      if (_conversationViewModel.messageResponseDto != null) {
        setState(() {
          messages[messages.length - 1] = MessageRendererModel(
              content: _conversationViewModel.messageResponseDto!.message,
              isUserMessage: false);
        });
      }

      if (_conversationViewModel.messageResponseDto != null) {
        setState(() {
          _conversationId =
              _conversationViewModel.messageResponseDto!.conversationId;
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottomAnimated();
      });
      // Clear the input field
    }

    if (_mediaFileList != null) {
      // Handle media file upload
      // Add media file to messages
      setState(() {
        messages.insert(
            messages.length,
            MessageRendererModel(
                content: 'Media file uploaded', isUserMessage: true));
      });

      // Clear the media file list
      setState(() {
        _mediaFileList = null;
      });
    }
  }
}

//d5c1b8ce-fff6-4e2e-8553-2d7b7b4e1438
