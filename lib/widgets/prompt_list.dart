import 'package:chatbot_agents/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';
import 'prompt_list_item.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/views/prompt/prompt_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/view_models/prompt_view_model.dart';
import 'package:chatbot_agents/service/prompt_service.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';

class PromptList extends StatefulWidget {
  final String? searchText;
  final PromptViewMode? viewMode;
  final PromptCategory? category;

  const PromptList({super.key, this.searchText, this.viewMode, this.category});

  @override
  State<PromptList> createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> with WidgetsBindingObserver {
  final PromptService _conversationService =
      GetItInstance.getIt<PromptService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _conversationService.getPrompts();
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

    
    void showDynamicInput(Prompt prompt) {
      print(prompt.content);
      List<String> placeholders = StringUtils.getAllPlacehoders(prompt.content);
      List<TextEditingController> controllers = placeholders.map((_) => TextEditingController()).toList();

      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prompt.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      ...placeholders.asMap().entries.map((entry) {
                        int index = entry.key;
                        String placeholder = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              labelText: placeholder,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 16),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            List<String> inputValues = controllers.map((controller) => controller.text).toList();
                            // Handle the collected input values here
                           String result = StringUtils.replacePlaceholders(prompt.content, inputValues);
                            // Handle the result here
                            print(result);
                            Navigator.of(context).pop(); // Close the bottom sheet
                          },
                          child: Text('Send'),
                        ),
                      )
                      // Add other dynamic input fields here if needed
                    ],
                  ),
                )
              );
            },
          );
        
        },
      );
    }

    void onPromptTap(Prompt prompt) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PromptDetailView(prompt)),
      // );

      showDynamicInput(prompt);

      
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
        child: Center(child: CircularProgressIndicator()),
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
