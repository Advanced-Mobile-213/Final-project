import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import './knowledge_list.dart';

class AddKnowledgeDialog extends StatefulWidget {
  final String assistantId;
  const AddKnowledgeDialog(this.assistantId, {super.key});

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  void _onAddKnowledgePress() {}

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Import Knowledge',
      onConfirm: _onAddKnowledgePress,
      children: [
        KnowledgeList(assistantId: widget.assistantId, isImported: false),
      ],
    );
  }
}

void showAddKnowledgeDialog(BuildContext context, String assistantId) {
  showDialog(
    context: context,
    builder: (context) => AddKnowledgeDialog(assistantId),
  );
}
