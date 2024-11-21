import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';

class PromptViewModel extends ChangeNotifier {
  // adding services here

  List<Prompt> prompts = [];
  bool isLoading = false;

  Future<void> getPrompts({
    String? query,
    int? offset,
    int? limit,
    PromptCategory? category,
    bool? isFavorite,
    bool? isPublic,
  }) async {
    // Fetch prompts from the server
    try {
      isLoading = true;

      // call the service here
      // delay for 2 seconds to simulate network request
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;

      // set the prompts here
      prompts = FakeData.prompts;
    } catch (e) {
      print('--> Error fetching prompts: $e');
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createPrompt({
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {
    try {
      isLoading = true;

      // call the service here

      isLoading = false;

      // add the new prompt to the list
      final Prompt newPrompt = Prompt(
        category: category,
        content: content,
        description: description,
        isPublic: isPublic,
        language: language,
        title: title,
      );

      // Fake the id, remove this line when the service is implemented
      newPrompt.id = DateTime.now().millisecondsSinceEpoch.toString();

      prompts.add(newPrompt);
    } catch (e) {
      print('--> Error creating prompt: $e');
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> updatePrompt({
    required String id,
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {
    try {
      isLoading = true;

      // call the service here

      isLoading = false;

      // update the prompt in the list
      final index = prompts.indexWhere((element) => element.id == id);
      if (index != -1) {
        prompts[index] = Prompt(
            id: id,
            category: category,
            content: content,
            description: description,
            isPublic: isPublic,
            language: language,
            title: title);
      }
    } catch (e) {
      print('--> Error updating prompt: $e');
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> deletePrompt(String id) async {
    try {
      isLoading = true;

      // call the service here

      isLoading = false;

      // remove the prompt from the list
      prompts.removeWhere((element) => element.id == id);
    } catch (e) {
      print('--> Error deleting prompt: $e');
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> addPromptToFavorite(String id) async {
    try {
      isLoading = true;

      // call the service here

      isLoading = false;

      // update the prompt in the list
      final index = prompts.indexWhere((element) => element.id == id);
      if (index != -1) {
        prompts[index].isFavorite = true;
      }
    } catch (e) {
      print('--> Error adding prompt to favorite: $e');
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> removePromptFromFavorite(String id) async {
    try {
      isLoading = true;

      // call the service here

      isLoading = false;

      // update the prompt in the list
      final index = prompts.indexWhere((element) => element.id == id);
      if (index != -1) {
        prompts[index].isFavorite = false;
      }
    } catch (e) {
      print('--> Error removing prompt from favorite: $e');
      isLoading = false;
    }
    notifyListeners();
  }
}
