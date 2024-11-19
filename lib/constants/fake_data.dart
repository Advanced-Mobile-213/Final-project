import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';

class FakeData {
  static List<String> aiBots = [
    'Gemini',
    'ChatGPT',
    'Bard',
    'Claude',
    'Claude-2'
  ];
  static List<Prompt> prompts = [
    Prompt(
      id: '1',
      createdAt: DateTime(2022, 1, 30).toString(),
      updatedAt: DateTime(2022, 1, 30).toString(),
      userId: '1',
      title: 'Prompt 1',
      content: 'Content 1',
      description: 'Description 1',
      category: PromptCategory.business,
      isPublic: true,
      language: 'en',
      userName: 'John Doe',
      isFavorite: false,
    ),
    Prompt(
      id: '2',
      createdAt: DateTime(2023, 1, 30).toString(),
      updatedAt: DateTime(2023, 1, 30).toString(),
      userId: '1',
      title: 'Prompt 2',
      content: 'Content 2',
      description: 'Description 2',
      category: PromptCategory.business,
      isPublic: true,
      language: 'en',
      userName: 'John Doe',
      isFavorite: false,
    ),
  ];
  static List<Knowledge> knowledge = [
    Knowledge(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeName: 'Jarvis knowledge',
      description:
          'Despecto sufficio taceo spiritus est utpote verbum basium traho ager. Commemoro aro dolor utpote. Virtus voluptas spiritus benigne suadeo sed maiores amet. Attero urbs cubitum vacuus civitas patior ventosus. Decens cerno deripio cui verumtamen tui vulgaris volubilis aliquid. Deludo totam corrupti decimus cras balbus. Comedo amiculum damnatio sufficio aro defendo eum. Titulus vir deorsum autus.',
    ),
    Knowledge(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 2',
      description: 'Description 2',
    ),
    Knowledge(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 3',
      description: 'Description 3',
    ),
    Knowledge(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 4',
      description: 'Description 4',
    ),
    Knowledge(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 5',
      description: 'Description 5',
    ),
    Knowledge(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 6',
      description: 'Description 6',
    ),
    Knowledge(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 7',
      description: 'Description 7',
    ),
    Knowledge(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 8',
      description: 'Description 8',
    ),
    Knowledge(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 9',
      description: 'Description 9',
    ),
    Knowledge(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 10',
      description: 'Description 10',
    ),
    Knowledge(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 11',
      description: 'Description 11',
    ),
    Knowledge(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 12',
      description: 'Description 12',
    ),
    Knowledge(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 13',
      description: 'Description 13',
    ),
    Knowledge(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 14',
      description: 'Description 14',
    ),
    Knowledge(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 15',
      description: 'Description 15',
    ),
    Knowledge(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeName: 'Knowledge 16',
      description: 'Description 16',
    ),
  ];
  static List<KnowledgeUnit> knowledgeUnits = [
    KnowledgeUnit(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 1',
      id: '1',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 2',
      id: '2',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 3',
      id: '3',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 4',
      id: '4',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 5',
      id: '5',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 6',
      id: '6',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 7',
      id: '7',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 8',
      id: '8',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2022, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 9',
      id: '9',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2023, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 10',
      id: '10',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2024, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit 11',
      id: '11',
    ),
    KnowledgeUnit(
      createdAt: DateTime(2021, 1, 30),
      userId: '1',
      knowledgeId: '1',
      name: 'Knowledge Unit',
      id: '12',
    ),
  ];
}
