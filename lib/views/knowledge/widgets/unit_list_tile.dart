import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:chatbot_agents/utils/string_utils.dart';
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
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${_getMetaData(widget.knowledgeUnit) ?? 'N/A'}\n',
                  style: const TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: StringUtils.formatDate(knowledgeUnit.updatedAt!),
                  style: const TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Switch(value: _isEnable,
            //   onChanged: (value) {
            //     setState(() {
            //       _isEnable = !_isEnable;
            //     });
            //   },
            //   activeColor: AppColors.quaternaryText,
            //   activeTrackColor: AppColors.tertiaryText,
            //   inactiveThumbColor: AppColors.quaternaryText,
            //   thumbColor: _isEnable
            //       ? WidgetStateProperty.all(AppColors.quaternaryText)
            //       : WidgetStateProperty.all(AppColors.tertiaryText),
            //   //inactiveTrackColor: AppColors.primaryBackground,
            // ),
            Text(knowledgeUnit.formattedType,
                style: const TextStyle(
                  color: AppColors.quaternaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),)
          ],
        )
      ),
    );
  }

  String? _getMetaData (KnowledgeUnit unit) {
    switch (unit.type) {
      case 'web':
        return unit.metadata['web_url'];
      case 'confluence':
        return unit.metadata['wiki_page_url'];
      case 'slack':
        return unit.metadata['slack_workspace'];
      case 'local_file':
        return unit.metadata['mimetype'];
      default:
        return 'Unknown';
    }
  }

}

                                