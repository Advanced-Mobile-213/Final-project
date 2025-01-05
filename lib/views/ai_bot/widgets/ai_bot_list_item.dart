import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import './ai_bot_detail_dialog.dart';
import '../ai_bot_detail_view.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';

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

class AiBotListItem extends StatefulWidget {
  final AiBot aiBot;
  final void Function(AiBot) onDeleted;
  final void Function() onFavoriteToggle;

  const AiBotListItem(this.aiBot, this.onDeleted, this.onFavoriteToggle,
      {super.key});

  @override
  AiBotListItemState createState() => AiBotListItemState();
}

class AiBotListItemState extends State<AiBotListItem> {
  late SnackBarUtil snackBarUtil;

  @override
  void initState() {
    super.initState();
    snackBarUtil = SnackBarUtil(context);
  }

  void onAiBotPressed(BuildContext context, AiBot aiBot) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiBotDetailView(assistantId: aiBot.id),
      ),
    );
  }

  void onUpdatePressed() {
    showAiBotDetailDialog(context, updatingAiBot: widget.aiBot);
  }

  void onFavoriteToggle() async {
    var aiBotViewModel = Provider.of<AiBotViewModel>(context, listen: false);
    await aiBotViewModel.favoriteAssistant(assistantId: widget.aiBot.id);
    if (aiBotViewModel.success) {
      snackBarUtil.showSuccess(
        !widget.aiBot.isFavorite
            ? "Assistant added to favorite"
            : "Assistant removed from favorite",
      );
      widget.onFavoriteToggle();
    } else {
      snackBarUtil.showError("Failed to add assistant to favorite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => onAiBotPressed(context, widget.aiBot),
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
                    widget.aiBot.assistantName,
                    style: _titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (widget.aiBot.description != null &&
                      widget.aiBot.description!.isNotEmpty)
                    Text(
                      widget.aiBot.description!,
                      style: _descriptionTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                ],
              ),
            ),
            TouchableOpacity(
              onTap: onFavoriteToggle,
              child: Icon(
                Icons.star,
                color: widget.aiBot.isFavorite ? Colors.yellow : Colors.white,
              ),
            ),
            TouchableOpacity(
              onTap: onUpdatePressed,
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            Gap(spacing[1]),
            TouchableOpacity(
              onTap: () => widget.onDeleted(widget.aiBot),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
