import 'package:flutter/material.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../constants/spacing.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../constants/app_colors.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: AppColors.quaternaryText,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: AppColors.quaternaryText,
);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.secondaryBackground,
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(
    color: AppColors.quaternaryText,
    width: 1.0,
  ),
);

Widget addIcon = const Icon(
  Icons.add,
  color: AppColors.quaternaryText,
);

Widget deleteIcon = const Icon(
  Icons.delete,
  color: AppColors.quaternaryText,
);

class KnowledgeListItem extends StatefulWidget {
  final Knowledge knowledge;
  final bool isImported;
  final void Function(Knowledge addingKnowledge) onAddKnowledgePress;
  final void Function(Knowledge deletingKnowledge) onDeleteKnowledgePress;

  const KnowledgeListItem({
    super.key,
    required this.knowledge,
    this.isImported = true,
    required this.onAddKnowledgePress,
    required this.onDeleteKnowledgePress,
  });

  @override
  State<KnowledgeListItem> createState() => _KnowledgeListItemState();
}

class _KnowledgeListItemState extends State<KnowledgeListItem> {
  @override
  Widget build(BuildContext context) {
    Widget endButton = TouchableOpacity(
      child: widget.isImported ? deleteIcon : addIcon,
      onTap: () {
        if (widget.isImported) {
          widget.onDeleteKnowledgePress(widget.knowledge);
        } else {
          widget.onAddKnowledgePress(widget.knowledge);
        }
      },
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: spacing[2],
        vertical: spacing[1],
      ),
      decoration: _containerDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.knowledge.knowledgeName,
                  style: _titleTextStyle,
                  maxLines: 1,
                ),
                Gap(spacing[1]),
                Text(
                  widget.knowledge.description,
                  style: _descriptionTextStyle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: endButton),
        ],
      ),
    );
  }
}
