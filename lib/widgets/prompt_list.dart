import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';
import 'prompt_list_item.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/views/prompt/prompt_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';

class PromptList extends StatefulWidget {
  final String? searchText;
  final PromptViewMode? viewMode;
  final PromptCategory? category;

  const PromptList({super.key, this.searchText, this.viewMode, this.category});

  @override
  State<PromptList> createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchPrompts();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchPrompts();
    }
  }

  Future<void> _fetchPrompts() async {
    final promptViewModel = context.read<PromptViewModel>();
    await promptViewModel.getPrompts();
  }

  List<Prompt> getFilteredPromptList(List<Prompt> promptList) {
    List<Prompt> result = promptList;

    if (widget.searchText != null && widget.searchText!.isNotEmpty) {
      result = result
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

    if (widget.category != null && widget.category != PromptCategory.all) {
      result =
          result.where((prompt) => prompt.category == widget.category).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final promptViewModel = context.watch<PromptViewModel>();

    void onPromptTap(Prompt prompt) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PromptDetailView(prompt)),
      );
    }

    void onPromptDeleted(Prompt prompt) {
      promptViewModel.deletePrompt(prompt.id!);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prompt deleted successfully')),
      );
    }

    void onPromptFavorite(Prompt prompt) {
      if (prompt.isFavorite) {
        promptViewModel.removePromptFromFavorite(prompt.id!);
      } else {
        promptViewModel.addPromptToFavorite(prompt.id!);
      }
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

    final Widget content;
    if (promptViewModel.isLoading) {
      content = const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else {
      final filteredPromptList = getFilteredPromptList(promptViewModel.prompts);
      content = Expanded(
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

    return content;
  }
}
