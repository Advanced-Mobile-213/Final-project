import 'package:chatbot_agents/models/knowledge/data_source.dart';
import 'enums.dart';


final List<DataSource> dataSources = [
  DataSource(
    name: 'Local File',
    description: 'Upload pdf, docx, etc',
    imagePath: 'assets/images/local_file.png',
    type: KnowledgeUnitType.localFile,
  ),
  DataSource(
    name: 'Website',
    description: 'Connect website to get data',
    imagePath: 'assets/images/website.png',
    type: KnowledgeUnitType.website,
  ),
  DataSource(
    name: 'Google Drive',
    description: 'Connect Google Drive to get data',
    imagePath: 'assets/images/google_drive.png',
    type: KnowledgeUnitType.googleDrive,
  ),
  DataSource(
    name: 'Slack',
    description: 'Connect Slack to get data',
    imagePath: 'assets/images/slack.png',
    type: KnowledgeUnitType.slack,
  ),
  DataSource(
    name: 'Confluence',
    description: 'Connect Confluence to get data',
    imagePath: 'assets/images/confluence.png',
    type: KnowledgeUnitType.confluence,
  ),
];
