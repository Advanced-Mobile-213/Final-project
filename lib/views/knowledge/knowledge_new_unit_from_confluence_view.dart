import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/snack_bar_util.dart';
import '../../view_models/knowledge_unit_view_model.dart';
import '../../widgets/text_input.dart';

class KnowledgeNewUnitFromConfluenceView extends StatefulWidget {
  final Knowledge knowledge;
  const KnowledgeNewUnitFromConfluenceView({super.key, required this.knowledge});
  @override
  State<KnowledgeNewUnitFromConfluenceView> createState() => _KnowledgeNewUnitFromConfluenceViewState();
}

class _KnowledgeNewUnitFromConfluenceViewState extends State<KnowledgeNewUnitFromConfluenceView> {
  final TextEditingController _nameInputFieldController = TextEditingController();
  final TextEditingController _wikiPageUrlInputFieldController = TextEditingController();
  final TextEditingController _usernameInputFieldController = TextEditingController();
  final TextEditingController _accessTokenInputFieldController = TextEditingController();
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
    final formKey = GlobalKey<FormState>();

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
        title: const Text('Add Unit From Confluence',
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.confluence,
                              color: AppColors.quaternaryText,
                            ),
                            SizedBox(width: 10.0),
                            Text('Confluence',
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
                        child: TextInput(keyboardType: TextInputType.multiline, label: "Name", controller: _nameInputFieldController, hintText: "Enter Name", isRequired: true,)
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: TextInput(keyboardType: TextInputType.multiline, label: "Wiki Page URL", controller: _wikiPageUrlInputFieldController, hintText: "Enter Wiki Page URL", isRequired: true,)

                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: TextInput(keyboardType: TextInputType.multiline, label: "Confluence Username", controller: _usernameInputFieldController, hintText: "Enter Confluence Username", isRequired: true,)
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: TextInput(keyboardType: TextInputType.multiline, label: "Confluence Access Token", controller: _accessTokenInputFieldController, hintText: "Enter Confluence Access Token", isRequired: true,)
                      ),
                      Container(
                        margin: const EdgeInsets.all(25.0),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: AppColors.secondaryBackground) :

                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              bool isSuccess = await _onConnect();
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
    final wikiPageUrl = _wikiPageUrlInputFieldController.text;
    if (wikiPageUrl.isEmpty) {
      return false;
    }
    final confluenceUsername = _usernameInputFieldController.text;
    if (confluenceUsername.isEmpty) {
      return false;
    }
    final confluenceAccessToken = _accessTokenInputFieldController.text;
    if (confluenceAccessToken.isEmpty) {
      return false;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final errorMessage = await readKnowledgeUnitViewModel.uploadFromConfluence(knowledgeId: widget.knowledge.id, unitName: name, wikiPageUrl: wikiPageUrl, confluenceUsername: confluenceUsername, confluenceAccessToken: confluenceAccessToken);
      if (errorMessage != null) {
        snackBarUtil.showDefault('Error: $errorMessage');
        return false;
      } else {
        snackBarUtil.showDefault('Confluence uploaded successfully!');
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