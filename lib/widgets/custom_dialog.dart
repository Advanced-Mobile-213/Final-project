import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';

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

  const CustomDialog(
      {required this.title,
      required this.children,
      required this.onConfirm,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: _textButtonStyle),
        ),
        // Save Button
        ElevatedButton(
          style: _confirmButtonStyle,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Save', style: _textButtonStyle),
        ),
      ],
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
