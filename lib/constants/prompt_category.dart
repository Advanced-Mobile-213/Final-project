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
  ai_painting,
}

extension PromptCategoryId on PromptCategory {
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
      case PromptCategory.ai_painting:
        return 'ai_painting';
      default:
        return 'all';
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
      case PromptCategory.ai_painting:
        return 'AI Painting';
    }
  }
}

PromptCategory getCategory(String id) {
  switch (id) {
    case 'business':
      return PromptCategory.business;
    case 'career':
      return PromptCategory.career;
    case 'chatbot':
      return PromptCategory.chatbot;
    case 'coding':
      return PromptCategory.coding;
    case 'education':
      return PromptCategory.education;
    case 'fun':
      return PromptCategory.fun;
    case 'marketing':
      return PromptCategory.marketing;
    case 'productivity':
      return PromptCategory.productivity;
    case 'seo':
      return PromptCategory.seo;
    case 'writing':
      return PromptCategory.writing;
    case 'other':
      return PromptCategory.other;
    case 'ai_painting':
      return PromptCategory.ai_painting;
    default:
      return PromptCategory.all;
  }
}
