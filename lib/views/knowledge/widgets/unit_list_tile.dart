import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:flutter/material.dart';

class UnitListTile extends StatefulWidget {
  final KnowledgeUnit knowledgeUnit;
  const UnitListTile({super.key, required this.knowledgeUnit});

  @override
  State<UnitListTile> createState() => _UnitListTileState();
}

class _UnitListTileState extends State<UnitListTile> {
  bool _isEnable = true;

  @override
  Widget build(BuildContext context) {
    final knowledgeUnit = widget.knowledgeUnit;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.quaternaryBackground,
          width: 1.0,
        ),
      ),
      child: ListTile(
        onTap: () {
          // _navigateToKnowledgeDetail();
        },
        title: Text(
          knowledgeUnit.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: AppColors.quaternaryText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          knowledgeUnit.knowledgeId,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: AppColors.quaternaryText,
            fontSize: 14,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Switch(value: _isEnable,
              onChanged: (value) {
                setState(() {
                  _isEnable = !_isEnable;
                });
              },
              activeColor: AppColors.quaternaryText,
              activeTrackColor: AppColors.tertiaryText,
              inactiveThumbColor: AppColors.quaternaryText,
              thumbColor: _isEnable
                  ? WidgetStateProperty.all(AppColors.quaternaryText)
                  : WidgetStateProperty.all(AppColors.tertiaryText),
              //inactiveTrackColor: AppColors.primaryBackground,
            ),
            IconButton(
              icon: const Icon(Icons.delete,
                color: AppColors.quaternaryText,
              ),
              onPressed: () {},
            ),
          ],
        )
        
      ),
    );
                      
  }
}

                                