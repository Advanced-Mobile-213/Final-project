import 'package:flutter/material.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../constants/spacing.dart';
import 'package:gap/gap.dart';
import 'knowledge_list_item.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:chatbot_agents/utils/snack_bar_util.dart';

const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class KnowledgeList extends StatefulWidget {
  final String assistantId;
  final bool isImported;

  const KnowledgeList({
    super.key,
    required this.assistantId,
    this.isImported = true,
  });

  @override
  State<KnowledgeList> createState() => _KnowledgeListState();
}

class _KnowledgeListState extends State<KnowledgeList>
    with WidgetsBindingObserver {
  late SnackBarUtil snackBarUtil;

  @override
  void initState() {
    super.initState();
    snackBarUtil = SnackBarUtil(context);
    WidgetsBinding.instance.addObserver(this);
    _fetchKnowledges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchKnowledges();
    }
  }

  void _fetchKnowledges() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final aiBotViewModel = context.read<AiBotViewModel>();
      if (widget.isImported == true) {
        await aiBotViewModel.getImportedKnowledgeInAssistant(
          assistantId: widget.assistantId,
        );
      } else {
        await aiBotViewModel.getUnImportedKnowledgeInAssistant(
          assistantId: widget.assistantId,
        );
      }
    });
  }

  void onAddKnowledgePress(Knowledge addingKnowledge) async {
    final aiBotViewModel = context.read<AiBotViewModel>();
    await aiBotViewModel.importKnowledgeToAssistant(
      assistantId: widget.assistantId,
      knowledge: addingKnowledge,
    );
    if (aiBotViewModel.success == true) {
      snackBarUtil.showSuccess('Knowledge imported successfully');
    }
  }

  void onDeleteKnowledgePress(Knowledge deletingKnowledge) async {
    final aiBotViewModel = context.read<AiBotViewModel>();
    await aiBotViewModel.removeKnowledgeFromAssistant(
      assistantId: widget.assistantId,
      knowledge: deletingKnowledge,
    );
    if (aiBotViewModel.success == true) {
      snackBarUtil.showSuccess('Knowledge removed successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiBotViewModel = context.watch<AiBotViewModel>();

    Widget content;
    if (aiBotViewModel.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      List<Knowledge> knowledgeItems;
      if (widget.isImported == true) {
        knowledgeItems = aiBotViewModel.importedKnowledges;
      } else {
        knowledgeItems = aiBotViewModel.unImportedKnowledges;
      }
      if (knowledgeItems.isEmpty) {
        content = const Center(
            child: Text('No Knowledge Found', style: _emptyTextStyle));
      } else {
        content = ListView.separated(
          itemBuilder: (context, index) => KnowledgeListItem(
            knowledge: knowledgeItems[index],
            isImported: widget.isImported,
            onAddKnowledgePress: (addingKnowledge) =>
                onAddKnowledgePress(addingKnowledge),
            onDeleteKnowledgePress: (deletingKnowledge) =>
                onDeleteKnowledgePress(deletingKnowledge),
          ),
          separatorBuilder: (context, index) => Gap(spacing[2]),
          itemCount: knowledgeItems.length,
        );
      }
    }

    return Expanded(child: content);
  }
}
