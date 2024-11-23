import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/utils/function/prompt_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/prompt_category.dart';
import '../../../view_models/prompt_view_model.dart';
import '../../prompt/widgets/detail_prompt_pop_up.dart';
typedef PromptSelectedCallback = void Function(String);

class PromptSelectionWidget extends StatefulWidget {
  PromptSelectedCallback onPromptSelected;
  TextEditingController textSendController;
  PromptSelectionWidget({super.key,
    required this.onPromptSelected,
    required this.textSendController,
  });

  @override
  _PromptSelectionWidgetState createState() => _PromptSelectionWidgetState();
}

class _PromptSelectionWidgetState extends State<PromptSelectionWidget> {
  late final PromptViewModel _promptViewModel;
  late final List<Prompt> _privatePrompts;
  late final List<Prompt> _publicPrompts;
  @override
  void initState() {
    super.initState();
    _promptViewModel = Provider.of<PromptViewModel>(context, listen: false);
    _promptViewModel.getPrompts(category: PromptCategory.other, isPublic: false, limit: 50);
    _promptViewModel.getPrompts(category: PromptCategory.business, isPublic:true, limit: 50);
    _privatePrompts = _promptViewModel.privatePrompts;
    _publicPrompts = _promptViewModel.publicPrompts;
    // TODO: handle loading
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.quaternaryBackground,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text(
              'My Prompt:',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true, // Allow ListView to shrink to fit
              children: _privatePrompts.map((prompt) {
                return ListTile(
                  title: Text(
                    prompt.title,
                    style: const TextStyle(color: AppColors.quaternaryText),
                  ),
                  onTap: () {
                    onPromptDetail(prompt);
                  },
                );
              }).toList(),
            ),
          ),
          const ListTile(
            title: Text(
              'Public Prompt:',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true, // Allow ListView to shrink to fit
              children: _publicPrompts.map((prompt) {
                return ListTile(
                  title: Text(
                    prompt.title,
                    style: const TextStyle(color: AppColors.quaternaryText),
                  ),
                  onTap: () {
                    onPromptDetail(prompt);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  void onPromptDetail(Prompt prompt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailPromptPopUpDialog(prompt: prompt, onUseInCurrentChat: (prompt) {
          sendCurrentChatThread(prompt);
        },
        );
      },
    );
  }

  void sendCurrentChatThread(Prompt prompt) {
    PromptUtil.showDynamicInput(context, prompt, widget.textSendController);
  }
}