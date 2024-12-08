import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/knowledge/knowledge.dart';
import '../../utils/snack_bar_util.dart';
import '../../view_models/knowledge_unit_view_model.dart';

class KnowledgeNewUnitFromSlackView extends StatefulWidget{
  final Knowledge knowledge;
  const KnowledgeNewUnitFromSlackView({super.key, required this.knowledge});

  @override
  State<KnowledgeNewUnitFromSlackView> createState() => KnowledgeNewUnitFromSlackViewState();
}

class KnowledgeNewUnitFromSlackViewState extends State<KnowledgeNewUnitFromSlackView>{
  final TextEditingController _nameInputFieldController = TextEditingController();
  final TextEditingController _workspaceInputFieldController = TextEditingController();
  final TextEditingController _botTokenInputFieldController = TextEditingController();
  late final SnackBarUtil snackBarUtil;
  late final KnowledgeUnitViewModel readKnowledgeUnitViewModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    readKnowledgeUnitViewModel = context.read<KnowledgeUnitViewModel>();
    snackBarUtil = SnackBarUtil(context);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: AppColors.quaternaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Unit From Slack',
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.slack,
                                color: AppColors.quaternaryText,
                              ),
                              const SizedBox(width: 10.0),
                              Text('Slack',
                                style: TextStyle(
                                  color: AppColors.quaternaryText,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.all(10.0),
                            child: TextInput(keyboardType: TextInputType.multiline, label: "Name", controller: _nameInputFieldController, hintText: "Enter name", isRequired: true,)
                        ),

                        Container(
                            margin: const EdgeInsets.all(10.0),
                            child: TextInput(keyboardType: TextInputType.multiline, label: "Slack Workspace", controller: _workspaceInputFieldController, hintText: "Enter Slack Workspace", isRequired: true,)
                        ),
                        Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextInput(keyboardType: TextInputType.multiline, label: "Slack Bot Token", controller: _botTokenInputFieldController, hintText: "Enter Slack Bot Token", isRequired: true,)

                        ),
                        Container(
                          margin: const EdgeInsets.all(25.0),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: AppColors.secondaryBackground) :
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await _onConnect();
                              }
                            },
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(AppColors.secondaryBackground),
                            ),
                            child: const Text('Connect',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      )

    );
  }
  Future<bool> _onConnect() async {
    final name = _nameInputFieldController.text;
    if (name.isEmpty) {
      return false;
    }
    final botToken = _botTokenInputFieldController.text;
    if (botToken.isEmpty) {
      return false;
    }
    final workspace = _workspaceInputFieldController.text;
    if (workspace.isEmpty) {
      return false;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final errorMessage = await readKnowledgeUnitViewModel.uploadFromSlack(knowledgeId: widget.knowledge.id, unitName: name, slackWorkspace: workspace, slackBotToken: botToken );
      if (errorMessage != null) {
        snackBarUtil.showDefault('Error: $errorMessage');
        return false;
      } else {
        snackBarUtil.showDefault('Slack uploaded successfully!');
        return true;
      }
    } catch (e) {
      snackBarUtil.showDefault('Error : $e');
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

}