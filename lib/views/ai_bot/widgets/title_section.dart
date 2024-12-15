import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/widgets/text_copy_icon.dart';

final BoxDecoration _sectionDecoration = BoxDecoration(
  color: AppColors.primaryBackground,
  borderRadius: BorderRadius.circular(8),
);

const TextStyle _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle _subtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

class TitleSection extends StatelessWidget {
  final int? sectionNumber;
  final String? title;
  final String? subtitle;
  final bool? canCopySubtitle;
  const TitleSection({
    super.key,
    this.sectionNumber,
    this.title,
    this.subtitle,
    this.canCopySubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget renderSectionNumber() => Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: _sectionDecoration,
              child: Text(sectionNumber.toString(), style: _subtitleStyle),
            ),
            Gap(spacing[2]),
          ],
        );

    Widget renderTitle() => Flexible(
          child: Text(
            title!,
            style: _titleStyle,
            overflow: TextOverflow.visible,
          ),
        );

    Widget renderSubTitle() => Row(
          children: [
            Flexible(
              child: Text(
                subtitle!,
                style: _subtitleStyle,
                overflow: TextOverflow.visible,
              ),
            ),
            if (canCopySubtitle!) TextCopyIcon(subtitle!),
          ],
        );

    return Column(
      children: [
        Row(
          children: [
            if (sectionNumber != null) renderSectionNumber(),
            if (title != null) renderTitle(),
          ],
        ),
        if (subtitle != null) renderSubTitle(),
      ],
    );
  }
}
