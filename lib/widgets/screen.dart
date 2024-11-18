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
  final bool canGoBack;
  final PreferredSizeWidget? appBar; // Add this line

  const Screen({
    super.key,
    this.title,
    required this.children,
    this.titleButton,
    this.titleAlignment = Alignment.centerLeft,
    this.scrollable = false,
    this.canGoBack = false,
    this.appBar, // Add this line
  });

  Widget _buildTitle(BuildContext context) {
    Widget titleSection;
    if (titleButton == null) {
      titleSection = Row(
        children: [
          if (canGoBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          Expanded(
            child: Align(
              alignment: titleAlignment,
              child: Text(title!, style: _titleTextStyle),
            ),
          ),
        ],
      );
    } else {
      titleSection = Row(
        children: [
          if (canGoBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: titleAlignment,
                  child: Text(title!, style: _titleTextStyle),
                ),
                titleButton!,
              ],
            ),
          ),
        ],
      );
    }

    return titleSection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: appBar, // Add this line
      body: SafeArea(
        child: Column(
          children: [
            if (title != null && appBar == null) // Modify this line
              Padding(
                padding: EdgeInsets.only(
                  top: spacing[2],
                  right: spacing[2],
                  left: spacing[2],
                ),
                child: _buildTitle(context),
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
