import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/enum_assisstant_id.dart';
import 'package:chatbot_agents/constants/enum_assistant_model.dart';
import 'package:chatbot_agents/view_models/email_reply_view_model.dart';
import 'package:chatbot_agents/views/email_reply/widget/email_input_text_field.dart';
import 'package:chatbot_agents/widgets/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmailReplyView extends StatefulWidget {
  const EmailReplyView({Key? key}) : super(key: key);

  @override
  _EmailReplyViewState createState() => _EmailReplyViewState();
}

class _EmailReplyViewState extends State<EmailReplyView> {
  //view model
  late final EmailReplyViewModel _emailReplyViewModel;

  // controller
  final TextEditingController _emailSubjectController = TextEditingController();
  final TextEditingController _emailContentController = TextEditingController();
  final TextEditingController _emailSenderController = TextEditingController();
  final TextEditingController _emailReceiverController = TextEditingController();
  final TextEditingController _emailReplyController = TextEditingController();

  // Prompt language
  final List<String> promptLanguage = ['Auto', 'English', 'Vietnamese', 'Japanese', 'India'];
  String chosenPromptLanguage = 'Auto';
  
  //Bots
  final List<String> bots = EnumAssisstantId.getAllAssistantIds();
  final List<int> costToken = [1,3,1,5,5,1];
  String selectedBot = 'gpt-4o-mini';

  // length
  final List<String> lengths = ['Auto', 'Short', 'Medium', 'Long'];
  String _selectedLength = 'Auto'; // Default selected value
  

  // actions
  final List<String> actions = ['Reply to this email', 'Thanks', 'Sorry', 'Yes', 'Follow Up', 'No', 'Request for More Information'];
  String _selectedAction = 'Reply to this email';

  // formality
  final List<String> formalities = ['Neutral', 'Casual', 'Formal'];
  String _selectedFormality = 'Neutral';

  // tone
  final List<String> tones = ['Witty', 'Direct', 'Personable', 'Sincere', 'Professional', 
  'Friendly', 'Informational', 'Inspirational', 'Encouraging', 'Supportive', 'Sympathetic', 
  'Uplifting', 'Motivational', 'Positive','Humorous', 'Confident', 'Optimistic', 'Concerned',
  'Hopeful', 'Excited', 'Relaxed', 'Curious','Surprised', 'Enthusiastic', 'Empathetic'];
  String _selectedTone = 'Sincere';

  // selected idea
  late String? _selectedIdea;

  static const TextStyle inputHeaderTextStyle = TextStyle(
    color: AppColors.quaternaryText,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  void initState() {
    super.initState();
    _emailReplyViewModel = context.read<EmailReplyViewModel>();
    _fetchRemainingToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: const Text('Email Reply',
            style: TextStyle(
                color: AppColors.quaternaryText,
                fontSize: 30,
            ),
            
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            _emailReplyViewModel.clearData();
            Navigator.pop(context); // Pops the current screen from the navigation stack
          },
        ),
        // title: IconButton(
        //   onPressed: () async {
        //     _fetchMoreConversationHistory();
        //   }, 
        //   icon: Icon(Icons.replay_outlined, color: Colors.white)
        // ),
        //centerTitle: true,
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
                  child: Text('$bot : ${costToken[bots.indexOf(bot)]} tokens', 
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
                Consumer<EmailReplyViewModel>(
                  builder: (context, EmailReplyViewModel emailReplyViewModel, child) {
                    if (emailReplyViewModel.tokenUsageResponse!=null
                      && emailReplyViewModel.tokenUsageResponse!.unlimited) {
                      return const Icon(FontAwesomeIcons.infinity);
                    }
              
                    return Text(
                      _emailReplyViewModel.remainingToken != 0 
                      ? _emailReplyViewModel.remainingToken.toString()
                      : '0', 
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    );
                  },
                ),
                
              ],
            ),
          ),
        ],
      ),
            
      body: Container(
        color: AppColors.primaryBackground,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            EmailInputTextField(
                              title: 'Email Subject', 
                              controller: _emailSubjectController, 
                              hintText: 'Enter email subject', 
                              minLines: 1, 
                              maxLines: 1,
                            ),
                            EmailInputTextField(
                              title: 'Original Email Content', 
                              controller: _emailContentController, 
                              hintText: 'Enter email content', 
                              minLines: 5, 
                              maxLines: 7
                            ),
                            EmailInputTextField(
                              title: 'Email sender', 
                              controller: _emailSenderController, 
                              hintText: 'Enter email sender',
                              minLines: 1, 
                              maxLines: 1,
                            ),
                            EmailInputTextField(
                              title: 'Email receiver', 
                              controller: _emailReceiverController, 
                              hintText: 'Enter email receiver',
                              minLines: 1, 
                              maxLines: 1,
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Actions',
                                      style: inputHeaderTextStyle,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: actions.map((String action) {
                                          return CategoryButton(
                                            label: action, 
                                            onPressed: () {
                                              setState(() {
                                                _selectedAction = action;
                                              });
                                              print('_selectedAction: $_selectedAction');
                                            },
                                            isActive: _selectedAction == action,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Length',
                                    style: inputHeaderTextStyle,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: lengths.map((String length) {
                                        return CategoryButton(
                                          label: length, 
                                          onPressed: () {
                                            setState(() {
                                              _selectedLength = length;
                                            });
                                            print('_selectedLength: $_selectedLength');
                                          },
                                          isActive: _selectedLength == length,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              )
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Formality',
                                    style: inputHeaderTextStyle,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: formalities.map((String formality) {
                                        return CategoryButton(
                                          label: formality, 
                                          onPressed: () {
                                            setState(() {
                                              _selectedFormality = formality;
                                            });
                                            print('_selectedFormality: $_selectedFormality');
                                          },
                                          isActive: _selectedFormality == formality,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              )
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Tone',
                                      style: inputHeaderTextStyle,
                                    ),
                                    ListTile(
                                      title: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.quaternaryBackground,
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: _selectedTone,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(color: AppColors.primaryText),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.quaternaryBackground,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedTone = newValue!;
                                            });
                                            print('_selectedTone: $_selectedTone');
                                          },
                                          items: tones
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Output Language',
                                      style: inputHeaderTextStyle,
                                    ),
                                    ListTile(
                                      title: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.quaternaryBackground,
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: chosenPromptLanguage,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(color: AppColors.primaryText),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.quaternaryBackground,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              chosenPromptLanguage = newValue!;
                                            });
                                            print('chosenPromptLanguage: $chosenPromptLanguage');
                                          },
                                          items: promptLanguage
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () async {
                                  _suggestEmailReplyIdeas();
                                },
                                child: const Text('Suggest reply ideas'),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
                                  foregroundColor: WidgetStateProperty.all(AppColors.quaternaryText),
                                ),
                              ),
                            ),

                            Consumer<EmailReplyViewModel>(
                              builder: (context, EmailReplyViewModel emailReplyViewModel, child)  {
                                if (emailReplyViewModel.isLoading==true) {
                                  print('loading...');
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.tertiaryBackground,
                                    ),
                                  );
                                } else if (emailReplyViewModel.ideasResponse != null 
                                && emailReplyViewModel.ideasResponse!.ideas.isNotEmpty) {
                                  List<String> ideas = emailReplyViewModel.ideasResponse!.ideas;
                                  //print('ideas: $ideas');
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text('Reply Ideas',
                                          style: inputHeaderTextStyle,
                                        ),
                                        ListTile(
                                          title: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(bottom: 5),
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.quaternaryBackground,
                                            ),

                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: _selectedIdea,
                                              hint: const Text('Select an idea'),
                                              icon: const Icon(Icons.arrow_drop_down),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(color: AppColors.primaryText),
                                              underline: Container(
                                                height: 2,
                                                color: AppColors.quaternaryBackground,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedIdea = newValue!;
                                                });
                                              },
                                              items: ideas.toSet().map<DropdownMenuItem<String>>(
                                                (String idea) {
                                                  //print('idea: $idea');
                                                  return DropdownMenuItem<String>(
                                                    value: idea,
                                                    child: Text(idea),
                                                  );
                                              }).toList(),
                                              
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  );
                                } 
                                return Container();
                              },
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () {
                                  _replyEmail();
                                },
                                child: const Text('Generate'),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
                                  foregroundColor: WidgetStateProperty.all(AppColors.quaternaryText),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Text('Preview',
                                            style: inputHeaderTextStyle,
                                          ),
                                          // IconButton(
                                          //   icon: const Icon(Icons.arrow_back_ios,
                                          //     color: AppColors.quaternaryText,
                                          //   ),
                                          //   onPressed: () {},
                                          // ),
                                          // Text('1/3',
                                          //   style: const TextStyle(
                                          //     color: AppColors.quaternaryText,
                                          //     fontSize: 15,
                                          //   ),
                                          // ),
                                          // IconButton(
                                          //   icon: const Icon(Icons.arrow_forward_ios,
                                          //     color: AppColors.quaternaryText,
                                          //   ),
                                          //   onPressed: () {},
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          // IconButton(
                                          //   icon: const Icon(Icons.contactless,
                                          //     color: AppColors.quaternaryText,
                                          //   ),
                                          //   onPressed: () {},
                                          // ),
                                          IconButton(
                                            icon: const Icon(Icons.refresh,
                                              color: AppColors.quaternaryText,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Consumer<EmailReplyViewModel>(
                                    builder: (context, EmailReplyViewModel emailReplyViewModel, child) {
                                      if (emailReplyViewModel.isReplying==true) {
                                        _emailReplyController.text = "Loading...";
                                      } else if (emailReplyViewModel.replyEmailResponse != null) {
                                        _emailReplyController.text = emailReplyViewModel.replyEmailResponse!.email;
                                      
                                      } 

                                      return TextField(
                                        controller: _emailReplyController,
                                        enabled: false,
                                        minLines: 5,
                                        maxLines: 10,
                                        textCapitalization: TextCapitalization.sentences,
                                        keyboardType: TextInputType.multiline,
                                        style: const TextStyle(
                                          color: AppColors.quaternaryText,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: AppColors.primaryBackground,
                                          hintText: 'I can\'t answer your question right now. I will get back to you soon. Thank you for your patience.',
                                          contentPadding: const EdgeInsets.all(10),
                                          hintStyle: const TextStyle(
                                            color: AppColors.greyText,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: AppColors.secondaryBackground,
                                              width: 4.0,
                                            ),
                                          ),
                                        ),
                                        onSubmitted: (value) {
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: _emailReplyController.text));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Copied to clipboard')),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
                                  foregroundColor: WidgetStateProperty.all(AppColors.quaternaryText),
                                ),
                                child: const Text('Copy'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),

    );
  }
  
   void _fetchRemainingToken() async {
    await _emailReplyViewModel.getTokenUsage();
    await _emailReplyViewModel.getRemainingToken();
  }

  void _suggestEmailReplyIdeas() async {
    if (_emailContentController.text.isEmpty || _emailSubjectController.text.isEmpty
    || _emailSenderController.text.isEmpty || _emailReceiverController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter full email information')),
      );
      return;
    }
    await _emailReplyViewModel.suggestEmailReplyIdeas(
      emailSubject: _emailSubjectController.text,
      emailContent: _emailContentController.text,
      emailSender: _emailSenderController.text,
      emailReceiver: _emailReceiverController.text,
      action: "Suggest 3 ideas for this email", //_selectedAction,
      length: _selectedLength, 
      emailLanguage: chosenPromptLanguage, 
      assistantModel: EnumAssistantModel.DIFY, 
      assistantId: selectedBot,
    );

    if (_emailReplyViewModel.ideasResponse != null
    && _emailReplyViewModel.ideasResponse!.ideas.isNotEmpty) {
      setState(() {
        _selectedIdea = _emailReplyViewModel.ideasResponse!.ideas[0];
      });
    }

     await _emailReplyViewModel.getTokenUsage();
  }

  void _replyEmail() async {
    if (_emailContentController.text.isEmpty || _emailSubjectController.text.isEmpty
    || _emailSenderController.text.isEmpty || _emailReceiverController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter full email information')),
      );
      return;
    }
    
    await _emailReplyViewModel.replyEmail(
      emailSubject: _emailSubjectController.text,
      emailContent: _emailContentController.text, 
      emailSender: _emailSenderController.text,
      emailReceiver: _emailReceiverController.text,
      emailLanguage: chosenPromptLanguage, 
      mainIdea: _selectedIdea!, 
      emailLength: _selectedLength, 
      emailFormality: _selectedFormality, 
      emailTone: _selectedTone, 
      emailAction: _selectedAction, 
      assistantModel:  EnumAssistantModel.DIFY, 
      assistantId: selectedBot
    );

    await _emailReplyViewModel.getTokenUsage();
  }
}

