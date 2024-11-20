import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';
import 'prompt_list_item.dart';
import 'package:gap/gap.dart';

final List<Prompt> promptList = FakeData.prompts;

class PromptList extends StatefulWidget {
  final String? searchText;
  final PromptViewMode? viewMode;
  final PromptCategory? category;

  const PromptList({super.key, this.searchText, this.viewMode, this.category});

  @override
  State<PromptList> createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> {
  List<Prompt> get filteredPromptList {
    List<Prompt> result;
    if (widget.searchText == null || widget.searchText!.isEmpty) {
      result = promptList;
    } else {
      result = promptList
          .where((prompt) => prompt.title
              .toLowerCase()
              .contains(widget.searchText!.toLowerCase()))
          .toList();
    }

    if (widget.viewMode != null) {
      switch (widget.viewMode) {
        case PromptViewMode.private:
          result = result.where((prompt) => !prompt.isPublic).toList();
          break;
        case PromptViewMode.public:
          result = result.where((prompt) => prompt.isPublic).toList();
          break;
        case PromptViewMode.favorite:
          result = result.where((prompt) => prompt.isFavorite).toList();
          break;
        default:
          break;
      }
    }

    if (widget.category != null) {
      if (widget.category != PromptCategory.all) {
        result = result
            .where((prompt) => prompt.category == widget.category)
            .toList();
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    void onPromptTap(Prompt prompt) {
      print('--> Prompt tapped');
    }

    void onPromptDeleted(Prompt prompt) {
      setState(() {
        promptList.remove(prompt);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prompt deleted successfully')),
      );
    }

    void onPromptFavorite(Prompt prompt) {
      setState(() {
        prompt.isFavorite = !prompt.isFavorite;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            prompt.isFavorite
                ? 'Prompt added to favorite'
                : 'Prompt removed from favorite',
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(spacing[2]),
        itemCount: filteredPromptList.length,
        itemBuilder: (context, index) {
          return PromptListItem(
            filteredPromptList[index],
            onPromptTap,
            onPromptDeleted,
            onPromptFavorite,
          );
        },
      ),
    );
  }
}
