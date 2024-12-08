import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/constants/enum_assistant_model.dart';
import 'package:chatbot_agents/mapper/message_mapper.dart';
import 'package:chatbot_agents/models/get_conversation_history/message_renderer_model.dart';
import 'package:chatbot_agents/utils/function/prompt_util.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/non_text_input_selection_widget.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_bottom_sheet.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_selection_widget.dart';
import 'package:chatbot_agents/widgets/text_input.dart' as CustomizedTextInput;
import 'package:flutter/material.dart';
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
import 'package:chatbot_agents/models/prompt/prompt.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import '../../../widgets/screen.dart';

class PreviewTab extends StatefulWidget {
  final Prompt? passingPrompt;
  final AiBot? aiBot;
  const PreviewTab(this.aiBot, {super.key, this.passingPrompt});

  @override
  State<PreviewTab> createState() => _PreviewTabState();
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class _PreviewTabState extends State<PreviewTab> {
  final TextEditingController _controller = TextEditingController();
  List<MessageRendererModel> messages = [];
  bool _showPromptSelection = false;
  bool _showNonTextInputSelection = false;
  List<XFile>? _mediaFileList;
  BuildContext? _bottomSheetContext;
  final ScrollController _scrollController = ScrollController();
  late final ConversationViewModel _conversationViewModel;
  late final ListConversationsViewModel _listConversationsViewModel;
  final List<String> bots = EnumAssisstantId.getAllAssistantIds();
  String selectedBot = 'gpt-4o-mini'; // Default bot
  final List<int> costToken = [1, 3, 1, 5, 5, 1];

  late String _conversationId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.passingPrompt != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        PromptUtil.showDynamicInput(
            context, widget.passingPrompt!, _controller);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Screen(
      children: [
        Expanded(
          child: Consumer<ConversationViewModel>(
            builder:
                (context, ConversationViewModel conversationViewModel, child) {
              if (messages.isNotEmpty) {
                return ListView.builder(
                  controller: _scrollController,
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
        ),
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
        Row(
          children: [
            IconButton(
              onPressed: () {
                _showNonTextInputSelectionBottomSheet();
              },
              icon: const Icon(Icons.add_box_outlined, color: Colors.white),
            ),
            Expanded(
              child: CustomizedTextInput.TextInput(
                  controller: _controller,
                  hintText: "Enter message",
                  onChanged: (value) {}),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () async {
                _sendMessage();
              },
            ),
          ],
        ),
      ],
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
        return PromptSelectionWidget(
          onPromptSelected: handlePromptSelection,
          textSendController: _controller,
        );
      },
    ).whenComplete(() {
      _bottomSheetContext = null;
    });
  }

  Widget _buildChatbotReply(MessageRendererModel message, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.android, color: Colors.white),
        ),
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
                          p: const TextStyle(color: Colors.white),
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
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromptSelection() {
    return Container(
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
              _controller.text += 'Prompt 2';
              setState(() {
                _showPromptSelection = false;
              });
            },
          ),
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
