import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/service/prompt_service.dart';

class PromptViewModel extends ChangeNotifier {
  // adding services here
  final PromptService _promptService = GetItInstance.getIt<PromptService>();

  List<Prompt> prompts = [];
  bool isLoading = false;
  List<Prompt> privatePrompts = [];
  List<Prompt> publicPrompts = [];
  Prompt? newPrompt;

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
      final result = await _promptService.getPrompts(
        query: query,
        offset: offset,
        limit: limit,
        category: category,
        isFavorite: isFavorite,
        isPublic: isPublic,
      );
      isLoading = false;

      prompts = result?.items ?? [];
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

      newPrompt = null;

      // call the service here
      newPrompt = await _promptService.createPrompt(
        category: category,
        content: content,
        description: description,
        isPublic: isPublic, 
        language: language, 
        title: title,
      );
      isLoading = false;

      if (newPrompt != null) {
        if (isPublic) {
          publicPrompts.add(newPrompt!);
        } else {
          privatePrompts.add(newPrompt!);
        }
      }

      notifyListeners();

    } catch (e) {
      print('--> Error creating prompt: $e');
      isLoading = false;
    }
    
  }

  Future<bool> updatePrompt({
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

      bool result = await _promptService.updatePrompt(
        id: id,
        category: category,
        content: content,
        description: description,
        isPublic: isPublic, 
        language: language, 
        title: title,
      );

      if (result) {
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
            title: title
          );
        }
      }
      
      isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      print('--> Error updating prompt: $e');
      isLoading = false;
    }
    return false;
  }

  Future<void> deletePrompt(String id) async {
    try {
      isLoading = true;

      // call the service here
      bool result = await _promptService.deletePrompt(id);

      if (result) {
        // update the prompt in the list
        prompts.removeWhere((element) => element.id == id);
      }

      isLoading = false;
      notifyListeners();
      // remove the prompt from the list
      
    } catch (e) {
      print('--> Error deleting prompt: $e');
      isLoading = false;
    }
    
  }

  Future<void> addPromptToFavorite(String id) async {
    try {
      isLoading = true;

      await _promptService.addPromptToFavorite(id);

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

      await _promptService.removePromptFromFavorite(id);

      isLoading = false;

      // remove the prompt from the list
      prompts.removeWhere((element) => element.id == id);
    } catch (e) {
      print('--> Error removing prompt from favorite: $e');
      isLoading = false;
    }
    notifyListeners();
  }
}
