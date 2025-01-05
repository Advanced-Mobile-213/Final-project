import 'package:flutter/material.dart';
import '../../../widgets/category_button.dart';
import '../../../constants/spacing.dart';
import '../../../constants/enum_ai_bot_view_mode.dart';
import 'package:gap/gap.dart';

class AiBotFilter extends StatefulWidget {
  final EnumAiBotViewMode selectedViewMode;
  final void Function(EnumAiBotViewMode) onViewModeSelected;

  const AiBotFilter(
      {super.key,
      required this.selectedViewMode,
      required this.onViewModeSelected});

  @override
  State<AiBotFilter> createState() => _AiBotFilterState();
}

class _AiBotFilterState extends State<AiBotFilter> {
  Widget filterButton(String label, EnumAiBotViewMode mode) {
    return CategoryButton(
      label: label,
      onPressed: () => widget.onViewModeSelected(mode),
      isActive: widget.selectedViewMode == mode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        filterButton('All', EnumAiBotViewMode.all),
        Gap(spacing[2]),
        filterButton('Published', EnumAiBotViewMode.published),
        Gap(spacing[2]),
        filterButton('My favorite', EnumAiBotViewMode.myFavorite),
      ],
    );
  }
}
