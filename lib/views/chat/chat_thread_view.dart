import 'package:chatbot_agents/views/ai_bot/widgets/non_text_input_selection_widget.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_bottom_sheet.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/prompt_selection_widget.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';

class ChatThreadView extends StatefulWidget {
  const ChatThreadView({super.key});

  @override
  _ChatThreadViewState createState() => _ChatThreadViewState();
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class _ChatThreadViewState extends State<ChatThreadView> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {'content': 'Hello! How can I assist you today?', 'isUserMessage': false},
    {'content': 'What can you do?', 'isUserMessage': true},
    {'content': 'I can help with many things like answering questions and more.', 'isUserMessage': false},
  ];
  bool _showPromptSelection = false;
  bool _showNonTextInputSelection = false;
  List<XFile>? _mediaFileList;
  BuildContext? _bottomSheetContext;
  // List of bots
  final List<String> bots = ['ChatGPT 4.0', 'Gemini', 'Claude'];
  String selectedBot = 'ChatGPT 4.0'; // Default bot
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the layout responsive
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
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
            child: ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['isUserMessage'];

                return isUserMessage
                    ? _buildMeReply(message, screenWidth)
                    : _buildChatbotReply(message, screenWidth);
              },
            ),
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
                  icon: Icon(
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
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
    );
  }

  Widget _buildChatbotReply(Map<String, dynamic> message, double screenWidth) {
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
            child: Text(
              message['content'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeReply(Map<String, dynamic> message, double screenWidth) {
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
            message['content'],
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

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
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

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Add user message
        messages.insert(messages.length,{'content': _controller.text, 'isUserMessage': true});

        // Simulate chatbot reply based on selected bot
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            messages.insert(messages.length, {
              'content': '[$selectedBot] This is a reply to: ${_controller.text}',
              'isUserMessage': false,
            });
          });
        });
      });

    

      // Clear the input field
      _controller.clear();
    }

    if (_mediaFileList != null) {
      // Handle media file upload
      // Add media file to messages
      setState(() {
        messages.insert(messages.length, {
          'content': 'Media file uploaded',
          'isUserMessage': true
        });
      });

      // Clear the media file list
      setState(() {
        _mediaFileList = null;
      });
    }
  }
}
