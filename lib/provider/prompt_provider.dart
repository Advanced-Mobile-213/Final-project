import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/prompt.dart';
import 'package:chatbot_agents/constants/constants.dart';

class PromptProvider with ChangeNotifier {
  // fetch prompts from the server (later)
  final List<Prompt> _prompts = FakeData.prompts;

  List<Prompt> get prompts => _prompts;

  void addPrompt(PromptCategory category, String content, String description,
      bool isPublic, String language, String title) {
    _prompts.add(Prompt(
      id: DateTime.now().toString(),
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      category: category,
      content: content,
      description: description,
      isPublic: isPublic,
      language: language,
      title: title,
      userId: "1",
      userName: "John Doe",
      isFavorite: false,
    ));
    notifyListeners();
  }

  void removePrompt(String id) {
    _prompts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updatePrompt(String id, PromptCategory category, String content,
      String description, bool isPublic, String language, String title) {
    final promptIndex = _prompts.indexWhere((element) => element.id == id);
    if (promptIndex >= 0) {
      _prompts[promptIndex] = Prompt(
        id: id,
        createdAt: _prompts[promptIndex].createdAt,
        updatedAt: _prompts[promptIndex].updatedAt,
        category: category,
        content: content,
        description: description,
        isPublic: isPublic,
        language: language,
        title: title,
        userId: _prompts[promptIndex].userId,
        userName: _prompts[promptIndex].userName,
        isFavorite: _prompts[promptIndex].isFavorite,
      );
      notifyListeners();
    }
  }

  void addPromptToFavorite(String id){
    // implement later
  }

  void removePromptFromFavorite(String id){
    // implement later
  }
}
