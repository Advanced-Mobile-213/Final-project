import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
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
import 'package:provider/provider.dart';

class AiBotDetailView extends StatefulWidget {
  final String assistantId;
  const AiBotDetailView({super.key, required this.assistantId});

  @override
  State<AiBotDetailView> createState() => _AiBotDetailViewState();
}

class _AiBotDetailViewState extends State<AiBotDetailView> {
  AiBot? aiBot;

  void getAssistant() async {
    var aiBotViewModel = context.read<AiBotViewModel>();
    var getAiBot = await aiBotViewModel.getAssistant(
      assistantId: widget.assistantId,
    );

    if (getAiBot != null) {
      setState(() {
        aiBot = getAiBot;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAssistant();
  }

  void onPublishBotPressed(AiBot aiBot) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AiBotPublishView(aiBot)),
    );
  }

  PreferredSizeWidget _tabBarHeader(AiBot aiBot) => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          aiBot.assistantName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        surfaceTintColor: Colors.white,
        bottom: const TabBar(
          labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Preview'),
            Tab(text: 'Knowledge'),
            Tab(text: 'Persona & Prompt'),
          ],
        ),
        actions: [
          WideButton(
            text: 'Publish',
            width: 100,
            onPressed: () => onPublishBotPressed(aiBot),
          ),
          Gap(spacing[2]),
        ],
      );

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (aiBot != null) {
      content = TabBarView(
        children: [
          PreviewTab(aiBot!),
          KnowledgeTab(aiBot!),
          PromptTab(aiBot!),
        ],
      );
    } else {
      content = const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 3,
      child: Screen(
        appBar: aiBot != null ? _tabBarHeader(aiBot!) : null,
        children: [Expanded(child: content)],
      ),
    );
  }
}
