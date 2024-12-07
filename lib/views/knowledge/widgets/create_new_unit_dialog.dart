import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_new_unit_from_confluence_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_new_unit_from_google_drive_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_new_unit_from_local_file_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_new_unit_from_slack_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge_new_unit_from_website_view.dart';
import 'package:chatbot_agents/views/knowledge/widgets/data_source_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateNewUnitDialog extends StatefulWidget {
  @override
  State<CreateNewUnitDialog> createState() => _CreateNewUnitDialogState();
}

class _CreateNewUnitDialogState extends State<CreateNewUnitDialog> {
  int _currentSelection = 4;

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create New Unit',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.quaternaryText,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close,
              color: AppColors.quaternaryText,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ignore: avoid_types_as_parameter_names
            DataSourceListTile(
              value: 1, 
              currentSelection: _currentSelection, 
              icon: Icons.feed_outlined, 
              title: 'Local Files', 
              subtitle: 'Upload pdf, docx, ...', 
              onChangedRadio: handleRadioValueChange,
            ),
            DataSourceListTile(value: 2, 
              currentSelection: _currentSelection, 
              icon: FontAwesomeIcons.globe, 
              title: 'Websites', 
              subtitle: 'Connect Website to get data', 
              onChangedRadio: handleRadioValueChange,
            ),
            DataSourceListTile(value: 3, 
              currentSelection: _currentSelection, 
              icon: FontAwesomeIcons.googleDrive, 
              title: 'Google Drive', 
              subtitle: 'Connect Google drive to get data', 
              onChangedRadio: handleRadioValueChange,
            ),
            DataSourceListTile(value: 4, 
              currentSelection: _currentSelection, 
              icon: FontAwesomeIcons.slack, 
              title: 'Slack', 
              subtitle: 'Connect Slack to get data', 
              onChangedRadio: handleRadioValueChange,
            ),
            DataSourceListTile(value: 5, 
              currentSelection: _currentSelection, 
              icon: FontAwesomeIcons.confluence, 
              title: 'Confluence', 
              subtitle: 'Connect Confluence to get data', 
              onChangedRadio: handleRadioValueChange,
            ),
            
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
            style: TextStyle(
              color: AppColors.tertiaryText,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Define the action to be performed when the button is pressed
            //Navigator.of(context).pop();
            _switchToCreateNewUnitView();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.quaternaryText,
            backgroundColor: AppColors.tertiaryBackground, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: const TextStyle(fontSize: 16), // Text style
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }

  void handleRadioValueChange(int value) {
    setState(() {
      //print(value);
      _currentSelection = value;
    });
  }

  void _switchToCreateNewUnitView() {
    Navigator.of(context).pop();
    switch(_currentSelection) {
      case 1:
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeNewUnitFromLocalFileView(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeNewUnitFromWebsiteView(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeNewUnitFromGoogleDriveView(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeNewUnitFromSlackView(),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeNewUnitFromConfluenceView(),
          ),
        );
        break;
      default:
        break;
    }
   
    
  }
}