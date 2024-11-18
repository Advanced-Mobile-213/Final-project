import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:gap/gap.dart';

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
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Screen(
        appBar: AppBar(
          title: const Text('Knowledge Detail'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Information'),
              Tab(text: 'Unit'),
            ],
          ),
        ),
        children: [
          Expanded(
            child: TabBarView(
              children: [
                _detailTab,
                _detailTab,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
