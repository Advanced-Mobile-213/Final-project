import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import './knowledge_list.dart';

class AddKnowledgeDialog extends StatefulWidget {
  const AddKnowledgeDialog({super.key});

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  void _onAddKnowledgePress() {
    print('--> Add Knowledge Pressed');
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Add Knowledge',
      onConfirm: _onAddKnowledgePress,
      children: const [KnowledgeList()],
    );
  }
}

void showAddKnowledgeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddKnowledgeDialog(),
  );
}
