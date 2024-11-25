import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/category_button.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/prompt_category.dart';

class CategoryFilter extends StatefulWidget {
  final PromptCategory selectedCategory;
  final void Function(PromptCategory) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: PromptCategory.values
            .map(
              (category) => Padding(
                padding: EdgeInsets.only(right: spacing[1]),
                child: CategoryButton(
                  label: category.name,
                  onPressed: () => widget.onCategorySelected(category),
                  isActive: widget.selectedCategory == category,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
