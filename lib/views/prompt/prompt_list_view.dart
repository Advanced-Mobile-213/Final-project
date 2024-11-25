import 'package:chatbot_agents/views/prompt/widgets/add_prompt_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import './sub_views/my_prompt_view.dart';
import './sub_views/public_prompt_view.dart';
import './sub_views/favorites_prompt_view.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/widgets/category_button.dart';
import '../../constants/enums.dart';
import '../../constants/prompt_category.dart';
import '../../constants/app_colors.dart';

class PromptListView extends StatefulWidget {
  const PromptListView({super.key});

  @override
  State<PromptListView> createState() => _PromptListViewState();
}

class _PromptListViewState extends State<PromptListView> {
  String searchText = '';
  PromptViewMode chosenViewMode = PromptViewMode.private;
  PromptCategory selectedCategory = PromptCategory.business;

  void onAddPromptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddPromptPopUpDialog();
        });
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
            label: 'My prompts',
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

    Widget content;

    switch (chosenViewMode) {
      case PromptViewMode.private:
        content = const MyPromptView();
        break;
      case PromptViewMode.public:
        content = const PublicPromptView();
        break;
      case PromptViewMode.favorite:
        content = const FavoritesPromptView();
        break;
    }

    return Scaffold(
      body: Screen(
        title: 'Prompt Library',
        // titleButton: WideButton(
        //   width: 100,
        //   text: 'Add',
        //   onPressed: () {
        //     onAddPromptDialog(context)
        //   },
        // ),
        titleButton: FloatingActionButton(
          onPressed: () => {onAddPromptDialog(context)},
          //_createNewThreadDialog(context),
          backgroundColor: AppColors.secondaryBackground,
          child: const Icon(
            Icons.add,
            color: AppColors.quaternaryText,
          ),
        ),
        children: [
          promptModeFilter,
          // Gap(spacing[2]),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 2,
          //       child: PromptCategorySelector(
          //         category: selectedCategory,
          //         onChanged: onCategorySelected,
          //         hasAllCategory: true,
          //       ),
          //     ),
          //     Expanded(
          //         flex: 3,
          //         child:
          //             SearchInput(hintText: 'Prompt name', onChanged: onSearch)),
          //   ],
          // ),
          // Gap(spacing[3]),
          // PromptList(
          //   searchText: searchText,
          //   viewMode: chosenViewMode,
          //   category: selectedCategory,
          // ),
          Gap(spacing[2]),
          content,
        ],
      ),
    );
  }
}
