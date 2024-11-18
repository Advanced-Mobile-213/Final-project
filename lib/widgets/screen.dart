import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

class Screen extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final Widget? titleButton;
  final AlignmentGeometry titleAlignment;
  final bool scrollable;

  const Screen({
    super.key,
    this.title,
    required this.children,
    this.titleButton,
    this.titleAlignment = Alignment.centerLeft,
    this.scrollable = false,
  });

  Widget _buildTitle() {
    if (titleButton == null) {
      return Align(
        alignment: titleAlignment,
        child: Text(title!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: titleAlignment,
          child: Text(title!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        titleButton!,
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
                padding: EdgeInsets.only(
                  top: spacing[2],
                  right: spacing[2],
                  left: spacing[2],
                ),
                child: _buildTitle(),
              ),
            if (scrollable)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(spacing[2]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spacing[2]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
