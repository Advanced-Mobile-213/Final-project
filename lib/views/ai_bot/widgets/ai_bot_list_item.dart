import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import './ai_bot_detail_dialog.dart';
import '../ai_bot_detail_view.dart';

// Styles
const TextStyle _titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle _descriptionTextStyle = TextStyle(
  color: Colors.white,
);

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.secondaryBackground,
  borderRadius: BorderRadius.circular(16.0),
);

class AiBotListItem extends StatelessWidget {
  final AiBot aiBot;
  final void Function(AiBot) onDeleted;

  const AiBotListItem(this.aiBot, this.onDeleted, {super.key});

  @override
  Widget build(BuildContext context) {
    void onAiBotPressed(BuildContext context, AiBot aiBot) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AiBotDetailView(aiBot: aiBot)),
      );
    }

    void onUpdatePressed() {
      showAiBotDetailDialog(context, updatingAiBot: aiBot);
    }

    return TouchableOpacity(
      onTap: () => onAiBotPressed(context, aiBot),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing[2],
          vertical: spacing[2],
        ),
        decoration: _containerDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aiBot.assistantName,
                    style: _titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (aiBot.description != null &&
                      aiBot.description!.isNotEmpty)
                    Text(
                      aiBot.description!,
                      style: _descriptionTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                ],
              ),
            ),
            TouchableOpacity(
              onTap: onUpdatePressed,
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            Gap(spacing[1]),
            TouchableOpacity(
              onTap: () => onDeleted(aiBot),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
