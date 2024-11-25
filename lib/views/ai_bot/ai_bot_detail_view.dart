import 'package:flutter/material.dart';
import '../../models/ai_bot/ai_bot.dart';
import 'package:gap/gap.dart';
import 'ai_bot_publish_view.dart';
import '../../widgets/screen.dart';
import '../../widgets/wide_button.dart';
import '../../constants/app_colors.dart';
import './sub_views/knowledge_tab.dart';
import './sub_views/preview_tab.dart';
import './sub_views/prompt_tab.dart';
import '../../constants/spacing.dart';

class AiBotDetailView extends StatefulWidget {
  final AiBot aiBot;
  const AiBotDetailView({super.key, required this.aiBot});

  @override
  State<AiBotDetailView> createState() => _AiBotDetailViewState();
}

class _AiBotDetailViewState extends State<AiBotDetailView> {
  void onPublishBotPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AiBotPublishView(widget.aiBot)),
    );
  }

  PreferredSizeWidget get _tabBarHeader => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.aiBot.assistantName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        surfaceTintColor: Colors.white,
        bottom: const TabBar(
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Preview'),
            Tab(text: 'Knowledge'),
            Tab(text: 'Prompts'),
          ],
        ),
        actions: [
          WideButton(
            text: 'Publish',
            width: 100,
            onPressed: onPublishBotPressed,
          ),
          Gap(spacing[2]),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Screen(
        appBar: _tabBarHeader,
        children: [
          Expanded(
            child: TabBarView(
              children: [
                PreviewTab(widget.aiBot),
                KnowledgeTab(widget.aiBot),
                PromptTab(widget.aiBot),
              ],
            ),
          )
        ],
      ),
    );
  }
}
