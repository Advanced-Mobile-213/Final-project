import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

// The widget
class Screen extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final Widget? titleButton;
  final AlignmentGeometry titleAlignment;

  const Screen({
    super.key,
    this.title,
    required this.children,
    this.titleButton,
    this.titleAlignment = Alignment.centerLeft,
  });

  Widget _buildTitle() {
    if (titleButton == null) {
      return Align(
        alignment: titleAlignment,
        child: Text(title!, style: _titleTextStyle),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: titleAlignment,
          child: Text(title!, style: _titleTextStyle),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: titleButton!,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: EdgeInsets.all(spacing[2]),
                child: _buildTitle(),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spacing[2]),
                child: Column(
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
