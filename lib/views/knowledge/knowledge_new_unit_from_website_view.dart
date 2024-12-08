import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/knowledge/knowledge.dart';
import '../../utils/snack_bar_util.dart';
import '../../view_models/knowledge_unit_view_model.dart';

class KnowledgeNewUnitFromWebsiteView extends StatefulWidget {
  final Knowledge knowledge;
  const KnowledgeNewUnitFromWebsiteView({super.key, required this.knowledge});

  @override
  State<KnowledgeNewUnitFromWebsiteView> createState()=> _KnowledgeNewUnitFromWebsiteViewState();
}

class _KnowledgeNewUnitFromWebsiteViewState extends State<KnowledgeNewUnitFromWebsiteView> {
  final TextEditingController _nameInputFieldController = TextEditingController();
  final TextEditingController _urlInputFieldController = TextEditingController();
  late final SnackBarUtil snackBarUtil;
  late final KnowledgeUnitViewModel readKnowledgeUnitViewModel;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
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
        title: const Text('Add Unit From Website',
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
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
                            Icon(FontAwesomeIcons.globe,
                              color: AppColors.quaternaryText,
                            ),
                            SizedBox(width: 10.0),
                            Text('Website',
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
                          child: TextInput(controller: _nameInputFieldController, label: 'Name', isRequired: true, hintText: 'Enter website name',)
                      ),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          child: TextInput(controller: _urlInputFieldController, label: 'Web URL', isRequired: true, hintText:'Enter website url',)
                      ),
                      Container(
                        margin: const EdgeInsets.all(25.0),
                        child:  _isLoading
                            ? const CircularProgressIndicator(color: AppColors.secondaryBackground) :
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await _onConnect();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryBackground,
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
          ),
        ),
      ),

    );
  }

  Future<bool> _onConnect() async {
    final websiteUrl = _urlInputFieldController.text;
    if (websiteUrl.isEmpty) {
      return false;
    }
    final name = _nameInputFieldController.text;
    if (name.isEmpty) {
      return false;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final errorMessage = await readKnowledgeUnitViewModel.uploadFromWebsite(knowledgeId: widget.knowledge.id, unitName: name, webUrl: websiteUrl);
      if (errorMessage != null) {
        snackBarUtil.showDefault('Error: $errorMessage');
        return false;
      } else {
        snackBarUtil.showDefault('Website URL uploaded successfully!');
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