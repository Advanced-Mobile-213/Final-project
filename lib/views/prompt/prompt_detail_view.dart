import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);

class PromptDetailView extends StatefulWidget {
  final Prompt prompt;
  const PromptDetailView(this.prompt, {super.key});

  @override
  State<PromptDetailView> createState() => _PromptDetailViewState();
}

class _PromptDetailViewState extends State<PromptDetailView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _langueController = TextEditingController();
  late bool isPublic;
  late PromptCategory category;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.prompt.title;
    _descriptionController.text = widget.prompt.description ?? '';
    _contentController.text = widget.prompt.content;
    _langueController.text = widget.prompt.language;
    isPublic = widget.prompt.isPublic;
    category = widget.prompt.category;
    isFavorite = widget.prompt.isFavorite;
  }

  void onUpdated() {
    widget.prompt.title = _titleController.text;
    widget.prompt.description = _descriptionController.text;
    widget.prompt.content = _contentController.text;
    widget.prompt.language = _langueController.text;
    widget.prompt.isPublic = isPublic;
    widget.prompt.category = category;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prompt saved successfully')),
    );
  }

  void onToggleFavorite() {
    widget.prompt.isFavorite = !widget.prompt.isFavorite;
    setState(() {
      isFavorite = widget.prompt.isFavorite;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.prompt.isFavorite
              ? 'Prompt added to favorite'
              : 'Prompt removed from favorite',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      canGoBack: true,
      scrollable: true,
      title: 'Prompt detail',
      titleButton: TouchableOpacity(
        onTap: onToggleFavorite,
        child: Icon(
          Icons.star,
          color: isFavorite ? Colors.yellow : Colors.white,
        ),
      ),
      children: [
        TextInput(
          label: 'Title',
          hintText: 'Enter prompt title',
          controller: _titleController,
          onChanged: (value) => _titleController.text = value,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Description',
          hintText: 'Enter prompt description',
          controller: _descriptionController,
          onChanged: (value) => _descriptionController.text = value,
          lineNumbers: 5,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Content',
          hintText: 'Enter prompt content',
          controller: _contentController,
          onChanged: (value) => _contentController.text = value,
          lineNumbers: 5,
        ),
        Gap(spacing[2]),
        TextInput(
          label: 'Language',
          hintText: 'Enter prompt language',
          controller: _langueController,
          onChanged: (value) => _langueController.text = value,
        ),
        Gap(spacing[2]),
        PromptCategorySelector(
          hasLabel: true,
          category: category,
          onChanged: (PromptCategory? value) {
            setState(() {
              category = value!;
            });
          },
        ),
        Gap(spacing[2]),
        Row(
          children: [
            const Text('Public', style: _textStyle),
            Gap(spacing[1]),
            Checkbox(
              value: isPublic,
              side: const BorderSide(color: Colors.white),
              onChanged: (bool? value) {
                setState(() {
                  isPublic = value!;
                });
              },
            ),
          ],
        ),
        WideButton(text: 'Save', onPressed: onUpdated),
      ],
    );
  }
}
