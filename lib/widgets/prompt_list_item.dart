import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:gap/gap.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: Colors.white,
);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.tertiaryBackground.withOpacity(0.3),
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(
    color: Colors.white,
    width: 1.0,
  ),
);

class PromptListItem extends StatefulWidget {
  final Prompt prompt;
  final void Function(Prompt) onTap;
  final void Function(Prompt) onDeleted;
  final void Function(Prompt) onFavorite;

  const PromptListItem(this.prompt, this.onTap, this.onDeleted, this.onFavorite,
      {super.key});

  @override
  State<PromptListItem> createState() => _PromptListItemState();
}

class _PromptListItemState extends State<PromptListItem> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        widget.onTap(widget.prompt);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing[2],
          vertical: spacing[1],
        ),
        decoration: _containerDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.prompt.title,
                    style: _titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.prompt.category.id,
                    style: _descriptionTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TouchableOpacity(
                  onTap: () => widget.onFavorite(widget.prompt),
                  child: Icon(Icons.star,
                      color: widget.prompt.isFavorite
                          ? Colors.yellow
                          : Colors.white),
                ),
                Gap(spacing[1]),
                TouchableOpacity(
                  onTap: () => widget.onDeleted(widget.prompt),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
