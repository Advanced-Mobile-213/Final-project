import 'package:flutter/material.dart';
import '../../../models/knowledge/knowledge.dart';
import '../../../constants/spacing.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../constants/app_colors.dart';

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

class KnowledgeListItem extends StatefulWidget {
  final Knowledge knowledge;
  const KnowledgeListItem(this.knowledge, {super.key});

  @override
  State<KnowledgeListItem> createState() => _KnowledgeListItemState();
}

class _KnowledgeListItemState extends State<KnowledgeListItem> {
  Widget get _deleteIcon => TouchableOpacity(
        onTap: () {},
        child: const Icon(Icons.delete, color: Colors.white),
      );

  @override
  Widget build(BuildContext context) {
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
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.knowledge.knowledgeName, style: _titleTextStyle),
                Gap(spacing[1]),
                Text(
                  widget.knowledge.description,
                  style: _descriptionTextStyle,
                ),
              ],
            ),
          ),
          _deleteIcon,
        ],
      ),
    );
  }
}
