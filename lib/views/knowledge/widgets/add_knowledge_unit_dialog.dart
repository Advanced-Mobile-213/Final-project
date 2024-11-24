import 'package:chatbot_agents/views/knowledge/widgets/data_source_item.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_dialog.dart';
import 'package:chatbot_agents/constants/enums.dart';
import 'package:chatbot_agents/constants/data_sources.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';

class AddKnowledgeUnitDialog extends StatefulWidget {
  const AddKnowledgeUnitDialog({super.key});

  @override
  State<AddKnowledgeUnitDialog> createState() => _AddKnowledgeUnitDialogState();
}

class _AddKnowledgeUnitDialogState extends State<AddKnowledgeUnitDialog> {
  KnowledgeUnitType selectedKnowledgeUnitType = KnowledgeUnitType.localFile;

  void onAddUnitConfirm() {
    // Add knowledge unit
  }

  void onDataSourceSelected(KnowledgeUnitType type) {
    setState(() {
      selectedKnowledgeUnitType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Add Unit',
      onConfirm: onAddUnitConfirm,
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => DataSourceItem(
              dataSources[index],
              selectedKnowledgeUnitType == dataSources[index].type,
              () => onDataSourceSelected(dataSources[index].type),
            ),
            separatorBuilder: (context, index) => Gap(spacing[3]),
            itemCount: dataSources.length,
          ),
        )
      ],
    );
  }
}

void showAddKnowledgeUnitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddKnowledgeUnitDialog(),
  );
}
