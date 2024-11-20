class EnumAssisstantId {
  static const String CLAUDE_3_HAIKU = "claude-3-haiku-20240307";
  static const String CLAUDE_35_SONNET = "claude-3-5-sonnet-20240620";
  static const String GEMINI_15_FLASH = "gemini-1.5-flash-latest";
  static const String GEMINI_15_PRO = "gemini-1.5-pro-latest";
  static const String GPT_4O = "gpt-4o";
  static const String GPT_4O_MINI = "gpt-4o-mini";

  static List<String> getAllAssistantIds() {
    return [
      CLAUDE_3_HAIKU,
      CLAUDE_35_SONNET,
      GEMINI_15_FLASH,
      GEMINI_15_PRO,
      GPT_4O,
      GPT_4O_MINI,
    ];
  }
}

// enum EnumAssistantID {
//   CLAUDE_3_HAIKU,
//   CLAUDE_35_SONNET,
//   GEMINI_15_FLASH,
//   GEMINI_15_PRO,
//   GPT_4O,
//   GPT_4O_MINI,
// }

// Map<EnumAssistantID, String> enumAssistantIDMap = {
//   EnumAssistantID.CLAUDE_3_HAIKU: 'claude-3-haiku-20240307',
//   EnumAssistantID.CLAUDE_35_SONNET: 'claude-3-5-sonnet-20240620',
//   EnumAssistantID.GEMINI_15_FLASH: 'gemini-1.5-flash-latest',
//   EnumAssistantID.GEMINI_15_PRO: 'gemini-1.5-pro-latest',
//   EnumAssistantID.GPT_4O: 'gpt-4o',
//   EnumAssistantID.GPT_4O_MINI: 'gpt-4o-mini',
// };
