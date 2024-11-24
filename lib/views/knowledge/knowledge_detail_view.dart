import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/views/knowledge/widgets/knowledge_unit_list.dart';
import 'package:chatbot_agents/views/knowledge/widgets/add_knowledge_unit_dialog.dart';
import 'package:chatbot_agents/widgets/text_input.dart';
import 'package:chatbot_agents/widgets/wide_button.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/constants/fake_data.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';

class KnowledgeDetailView extends StatefulWidget {
  final Knowledge knowledge;
  const KnowledgeDetailView({required this.knowledge, super.key});

  @override
  State<KnowledgeDetailView> createState() => _KnowledgeDetailViewState();
}

class _KnowledgeDetailViewState extends State<KnowledgeDetailView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.knowledge.knowledgeName;
    descriptionController.text = widget.knowledge.description;
  }

  void onSave() {
    // update knowledge
    Knowledge updateKnowledge = FakeData.knowledge.firstWhere(
        (element) => element.createdAt == widget.knowledge.createdAt);

    updateKnowledge.knowledgeName = titleController.text;
    updateKnowledge.description = descriptionController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Knowledge updated!')),
    );
  }

  Widget get _detailTab {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Gap(spacing[2]),
          TextInput(
            controller: titleController,
            label: 'Title',
            hintText: 'Enter title',
            onChanged: (value) => setState(() {
              titleController.text = value;
            }),
          ),
          Gap(spacing[2]),
          TextInput(
            controller: descriptionController,
            label: 'Description',
            hintText: 'Enter description',
            onChanged: (value) => setState(() {
              descriptionController.text = value;
            }),
            lineNumbers: 10,
          ),
          Gap(spacing[6]),
          WideButton(text: 'Save', onPressed: onSave),
        ],
      ),
    );
  }

  void onAddUnit() {
    showAddKnowledgeUnitDialog(context);
  }

  Widget get _unitsTab {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(spacing[2]),
        WideButton(text: 'Add unit', onPressed: onAddUnit),
        Gap(spacing[4]),
        KnowledgeUnitList(widget.knowledge.userId),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Screen(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Knowledge Detail',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryBackground,
          surfaceTintColor: Colors.white,
          bottom: const TabBar(
            labelStyle: TextStyle(color: Colors.white),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Information'),
              Tab(text: 'Units'),
            ],
          ),
        ),
        children: [
          Expanded(
            child: TabBarView(
              children: [
                _detailTab,
                _unitsTab,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
