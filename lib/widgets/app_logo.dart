import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_icons.dart';
import '../utils/app_utils.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  final void Function()? onPress;
  const AppLogo(
      {super.key, required this.height, required this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SizedBox(
        width: width,
        height: height,
        child: Image.memory(
          AppUtils.bytesFromBase64String(AppIcons.AppIconBase64ImageString),
        ),
      ),
      onPressed: onPress,
    );
  }
}
