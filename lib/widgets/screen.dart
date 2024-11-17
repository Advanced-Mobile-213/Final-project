import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';

const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

class Screen extends StatelessWidget {
  final List<Widget> children;
  final double? gap;
  final String? title;
  final Alignment? titleAlignment;
  final Widget? titleButton;

  const Screen({
    super.key,
    required this.children,
    this.gap,
    this.title,
    this.titleAlignment,
    this.titleButton,
  });

  @override
  Widget build(BuildContext context) {
    final widgetGap = gap ?? spacing[2];
    final widgetTitleAlignment = titleAlignment ?? Alignment.centerLeft;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(spacing[2]),
          child: Column(
            children: [
              if (title != null && titleButton == null)
                Align(
                  alignment: widgetTitleAlignment,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: spacing[2]),
                    child: Text(title!, style: _titleTextStyle),
                  ),
                ),
              if (title != null && titleButton != null)
                Padding(
                  padding: EdgeInsets.only(bottom: spacing[2]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: widgetTitleAlignment,
                        child: Text(title!, style: _titleTextStyle),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: titleButton!,
                      )
                    ],
                  ),
                ),
              Gap(spacing[2]),
              ...children.map(
                (child) => Padding(
                  padding: EdgeInsets.only(bottom: widgetGap),
                  child: Align(alignment: Alignment.center, child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
