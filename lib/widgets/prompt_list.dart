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

const TextStyle _emptyTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class PromptList extends StatefulWidget {
  final String? query;
  final int? offset;
  final int? limit;
  final PromptCategory? category;
  final bool? isFavorite;
  final bool? isPublic;

  const PromptList({
    super.key,
    this.query,
    this.offset,
    this.limit,
    this.category,
    this.isFavorite,
    this.isPublic,
  });

  @override
  State<PromptList> createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> with WidgetsBindingObserver {
  //final PromptService _promptService = GetItInstance.getIt<PromptService>();

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

  @override
  void didUpdateWidget(covariant PromptList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query ||
        widget.offset != oldWidget.offset ||
        widget.limit != oldWidget.limit ||
        widget.category != oldWidget.category ||
        widget.isFavorite != oldWidget.isFavorite ||
        widget.isPublic != oldWidget.isPublic) {
      _fetchPrompts();
    }
  }

  Future<void> _fetchPrompts() async {
    final promptViewModel = context.read<PromptViewModel>();
    await promptViewModel.getPrompts(
      query: widget.query,
      offset: widget.offset,
      limit: widget.limit,
      category: widget.category,
      isFavorite: widget.isFavorite,
      isPublic: widget.isPublic,
    );
  }

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


  @override
  Widget build(BuildContext context) {
    final promptViewModel = context.watch<PromptViewModel>();
    
    void onPromptTap(Prompt prompt) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PromptDetailView(prompt)),
      );

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
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prompt removed from favorite')),
        );
      } else {
        promptViewModel.addPromptToFavorite(prompt.id!);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prompt added to favorite')),
        );
      }
    }

    final Widget content;
    if (promptViewModel.isLoading) {
      content = const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      if (promptViewModel.prompts.isEmpty) {
        content = const Expanded(
          child:
              Center(child: Text('No prompts found', style: _emptyTextStyle)),
        );
      } else {
        final filteredPromptList = promptViewModel.prompts;
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
    }
    return content;
  }
}
