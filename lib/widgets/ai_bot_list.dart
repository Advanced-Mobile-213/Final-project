import 'package:chatbot_agents/models/models.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/widget.dart';

final List<AiBot> aiBots = FakeData.aiBots;

class AiBotList extends StatefulWidget {
  final String searchingText;

  const AiBotList(this.searchingText, {super.key});

  @override
  State<AiBotList> createState() => _AiBotListState();
}

class _AiBotListState extends State<AiBotList> {
  List<AiBot> get filteredAIBots {
    if (widget.searchingText.isEmpty) {
      return aiBots;
    } else {
      return aiBots
          .where((element) => element.assistantName
              .toLowerCase()
              .contains(widget.searchingText.toLowerCase()))
          .toList();
    }
  }

  void onAIBotDelete(AiBot aibot) {
    setState(() {
      aiBots.remove(aibot);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI Bot deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemCount: filteredAIBots.length,
      separatorBuilder: (context, index) => Gap(spacing[2]),
      itemBuilder: (context, index) {
        return AiBotListItem(
          filteredAIBots[index],
          (aibot) => onAIBotDelete(aibot),
        );
      },
    ));
  }
}