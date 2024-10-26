import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DataSourceListTile extends StatefulWidget {
  int value;
  int currentSelection;
  IconData icon;
  String title;
  String subtitle;
  void Function(int) onChangedRadio;
  DataSourceListTile({
    Key? key, 
    required this.value, 
    required this.currentSelection,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChangedRadio,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState()=> _DataSourceListTileState();
}

class _DataSourceListTileState extends State<DataSourceListTile> {
  int _value = 1;


  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
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
         widget.onChangedRadio(_value);
        },
       
        title: Row(
          children: [
            Icon(widget.icon, color: AppColors.quaternaryText),
            const SizedBox(width: 5.0),
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.quaternaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Text(
          widget.subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: AppColors.quaternaryText,
            fontSize: 14,
          ),
        ),
        leading: Radio(
          value: _value,
          groupValue: widget.currentSelection,
          onChanged: (value) {
            widget.onChangedRadio(value as int);
          },
          fillColor: const WidgetStatePropertyAll(AppColors.quaternaryText),
                            
        ),
      ),
    );
  }
}