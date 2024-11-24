import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:gap/gap.dart';
import '../constants/spacing.dart';

const TextStyle _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _textButtonStyle = TextStyle(color: Colors.white);

final ButtonStyle _confirmButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.tertiaryBackground,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
);

class CustomDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final void Function() onConfirm;

  const CustomDialog({
    required this.title,
    required this.children,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing[2]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: _titleStyle,
            ),
            Gap(spacing[2]),
            ...children,
            Gap(spacing[2]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel', style: _textButtonStyle),
                ),
                Gap(spacing[1]),
                ElevatedButton(
                  style: _confirmButtonStyle,
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm', style: _textButtonStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context, String title, List<Widget> children,
    void Function() onConfirm) {
  showDialog(
    context: context,
    builder: (context) => CustomDialog(
      title: title,
      onConfirm: onConfirm,
      children: children,
    ),
  );
}
