import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:gap/gap.dart';

class PromptView extends StatefulWidget {
  const PromptView({super.key});

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  String searchText = '';
  PromptViewMode chosenViewMode = PromptViewMode.all;
  PromptCategory selectedCategory = PromptCategory.all;

  void onAddPromptDialog(BuildContext context) {
    showAddPromptDialog(context);
  }

  void onSearch(String value) {
    setState(() {
      searchText = value;
    });
  }

  void onViewModeSelected(PromptViewMode mode) {
    setState(() {
      chosenViewMode = mode;
    });
  }

  bool isModeSelected(PromptViewMode specification) {
    return chosenViewMode == specification;
  }

  void onCategorySelected(PromptCategory category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget promptModeFilter = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton(
            label: 'All prompts',
            onPressed: () => onViewModeSelected(PromptViewMode.all),
            isActive: isModeSelected(PromptViewMode.all),
          ),
          Gap(spacing[2]),
          CategoryButton(
            label: 'Private prompts',
            onPressed: () => onViewModeSelected(PromptViewMode.private),
            isActive: isModeSelected(PromptViewMode.private),
          ),
          Gap(spacing[2]),
          CategoryButton(
            label: 'Public prompts',
            onPressed: () => onViewModeSelected(PromptViewMode.public),
            isActive: isModeSelected(PromptViewMode.public),
          ),
          Gap(spacing[2]),
          CategoryButton(
            label: 'Favorite prompts',
            onPressed: () => onViewModeSelected(PromptViewMode.favorite),
            isActive: isModeSelected(PromptViewMode.favorite),
          ),
        ],
      ),
    );

    return Screen(
      title: 'Prompt Library',
      titleButton: WideButton(
        text: 'Add',
        width: 100,
        onPressed: () => onAddPromptDialog(context),
      ),
      children: [
        promptModeFilter,
        Gap(spacing[2]),
        Row(
          children: [
            Expanded(
              child: PromptCategorySelector(
                category: selectedCategory,
                onChanged: onCategorySelected,
              ),
            ),
            Expanded(
                flex: 2,
                child:
                    SearchInput(hintText: 'Prompt name', onChanged: onSearch)),
          ],
        ),
        Gap(spacing[3]),
        PromptList(
          searchText: searchText,
          viewMode: chosenViewMode,
          category: selectedCategory,
        ),
      ],
    );
  }
}
