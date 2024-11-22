class StringUtils {
  static List<String> getAllPlacehoders(String input) {
    RegExp regExp = RegExp(r'\[(.*?)\]');

    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    List<String> results = matches.map((match) => match.group(1)!).toList();

    return results;
  }

  static String replacePlaceholders(String content, List<String> values) {
    RegExp regExp = RegExp(r'\[(.*?)\]');
    int index = 0;
      return content.replaceAllMapped(regExp, (match) {
        if (index < values.length) {
          return values[index++];
        }
        return match.group(0)!; // Return the original placeholder if no value is available
      }
    );
  }

}