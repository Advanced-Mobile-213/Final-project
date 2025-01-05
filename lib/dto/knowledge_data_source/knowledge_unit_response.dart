
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';

class KnowledgeUnitResponse {
  final KnowledgeUnit? data;
  final String? errorMessage;
  const KnowledgeUnitResponse({this.data, this.errorMessage});
}