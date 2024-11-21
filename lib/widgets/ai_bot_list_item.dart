import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

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
    void onAiBotTap(BuildContext context, AiBot aiBot) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => AiBotDetailView(aiBot: aiBot),
      //   ),
      // );
    }

    return TouchableOpacity(
      onTap: () => onAiBotTap(context, aiBot),
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
                  if (aiBot.description != null)
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
              onTap: () => onDeleted(aiBot),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
