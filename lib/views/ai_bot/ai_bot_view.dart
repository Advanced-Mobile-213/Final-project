import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/screen.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import 'package:chatbot_agents/views/ai_bot/widgets/ai_bot_list.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'widgets/ai_bot_detail_dialog.dart';
import '../../constants/enum_ai_bot_view_mode.dart';

const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16);

class AiBotView extends StatefulWidget {
  const AiBotView({super.key});

  @override
  State<AiBotView> createState() => _AiBotViewState();
}

class _AiBotViewState extends State<AiBotView> {
  String query = '';
  bool? isFavorite;
  bool? isPublished;
  EnumAiBotViewMode selectedViewMode = EnumAiBotViewMode.all;

  void onTextChange(String text) {
    setState(() {
      query = text;
    });
  }

  void onViewModeChange(EnumAiBotViewMode? mode) {
    if (mode == EnumAiBotViewMode.all) {
      setState(() {
        isFavorite = null;
        isPublished = null;
        selectedViewMode = EnumAiBotViewMode.all;
      });
    } else if (mode == EnumAiBotViewMode.myFavorite) {
      setState(() {
        isFavorite = true;
        isPublished = null;
        selectedViewMode = EnumAiBotViewMode.myFavorite;
      });
    } else if (mode == EnumAiBotViewMode.published) {
      setState(() {
        isFavorite = null;
        isPublished = true;
        selectedViewMode = EnumAiBotViewMode.published;
      });
    }
  }

  void onNewAiBotPressed(BuildContext context) {
    showAiBotDetailDialog(context);
  }

  Widget renderModeSelector() {
    List<EnumAiBotViewMode> items = EnumAiBotViewMode.values;

    return (DropdownButton<EnumAiBotViewMode>(
      value: selectedViewMode,
      dropdownColor: Colors.black,
      onChanged: (value) => onViewModeChange(value),
      items: items
          .map((EnumAiBotViewMode mode) => DropdownMenuItem(
              value: mode,
              child: Text(
                getModeTitle(mode),
                style: _textStyle,
              )))
          .toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: 'AI Bot',
        titleButton: FloatingActionButton(
          onPressed: () => onNewAiBotPressed(context),
          backgroundColor: AppColors.secondaryBackground,
          child: const Icon(Icons.add, color: AppColors.quaternaryText),
        ),
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: renderModeSelector()),
              Gap(spacing[2]),
              Expanded(
                flex: 2,
                child: SearchInput(
                  hintText: 'AI Bot Name',
                  onChanged: onTextChange,
                ),
              )
            ],
          ),
          Gap(spacing[3]),
          AiBotList(
            searchingText: query,
            isFavorite: isFavorite,
            isPublished: isPublished,
          ),
        ]);
  }
}
