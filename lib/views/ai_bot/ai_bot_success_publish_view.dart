import 'package:flutter/material.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import './widgets/published_type_list.dart';

const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.secondaryBackground.withOpacity(0.7),
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(color: Colors.white, width: 1.0),
);

class AiBotSuccessPublishView extends StatelessWidget {
  final String assistantId;
  final bool slack;
  final bool telegram;
  final bool messenger;
  const AiBotSuccessPublishView({
    super.key,
    required this.assistantId,
    required this.slack,
    required this.telegram,
    required this.messenger,
  });

  Widget get successPublishBlock {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: spacing[2]),
      decoration: _containerDecoration,
      child: const Center(
        child: Text('Publication submitted', style: _titleTextStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: '',
      canGoBack: true,
      children: [
        successPublishBlock,
        Gap(spacing[4]),
        PublishedTypeList(
          assistantId: assistantId,
          slack: slack,
          telegram: telegram,
          messenger: messenger,
        ),
      ],
    );
  }
}
