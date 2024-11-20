import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';

const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);

class PromptCategorySelector extends StatelessWidget {
  final PromptCategory category;
  final void Function(PromptCategory) onChanged;
  final bool hasLabel;

  const PromptCategorySelector({
    required this.category,
    required this.onChanged,
    this.hasLabel = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasLabel) const Text('Category', style: _textStyle),
        Gap(spacing[1]),
        DropdownButton<PromptCategory>(
          value: category,
          dropdownColor: Colors.black,
          onChanged: (PromptCategory? newCategory) => onChanged(newCategory!),
          items: PromptCategory.values
              .map((PromptCategory category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.toString().split('.').last,
                      style: _textStyle,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
