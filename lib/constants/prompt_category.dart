enum PromptCategory {
  business,
  career,
  chatbot,
  coding,
  education,
  fun,
  marketing,
  productivity,
  seo,
  writing,
  other,
}

extension PromptCategoryId on PromptCategory{
  String get id {
    switch (this) {
      case PromptCategory.business:
        return 'business';
      case PromptCategory.career:
        return 'career';
      case PromptCategory.chatbot:
        return 'chatbot';
      case PromptCategory.coding:
        return 'coding';
      case PromptCategory.education:
        return 'education';
      case PromptCategory.fun:
        return 'fun';
      case PromptCategory.marketing:
        return 'marketing';
      case PromptCategory.productivity:
        return 'productivity';
      case PromptCategory.seo:
        return 'seo';
      case PromptCategory.writing:
        return 'writing';
      case PromptCategory.other:
        return 'other';
    }
  }
}

extension PromptCategoryTitle on PromptCategory {
  String get title {
    switch (this) {
      case PromptCategory.business:
        return 'Business';
      case PromptCategory.career:
        return 'Career';
      case PromptCategory.chatbot:
        return 'Chatbot';
      case PromptCategory.coding:
        return 'Coding';
      case PromptCategory.education:
        return 'Education';
      case PromptCategory.fun:
        return 'Fun';
      case PromptCategory.marketing:
        return 'Marketing';
      case PromptCategory.productivity:
        return 'Productivity';
      case PromptCategory.seo:
        return 'SEO';
      case PromptCategory.writing:
        return 'Writing';
      case PromptCategory.other:
        return 'Other';
    }
  }
}
