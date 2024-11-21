import 'package:chatbot_agents/constants/constants.dart';

class DataSource {
  final String name;
  final String description;
  final String imagePath;
  final KnowledgeUnitType type;

  DataSource({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.type,
  });
}
