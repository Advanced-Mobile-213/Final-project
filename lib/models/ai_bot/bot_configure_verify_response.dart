// ignore_for_file: non_constant_identifier_names

class Result {
  final int id;
  final bool is_bot;
  final String first_name;
  final String username;
  final bool can_join_groups;
  final bool can_read_all_group_messages;
  final bool supports_inline_queries;
  final bool can_connect_to_business;
  final bool has_main_web_app;

  Result({
    required this.id,
    required this.is_bot,
    required this.first_name,
    required this.username,
    required this.can_join_groups,
    required this.can_read_all_group_messages,
    required this.supports_inline_queries,
    required this.can_connect_to_business,
    required this.has_main_web_app,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      is_bot: json['is_bot'],
      first_name: json['first_name'],
      username: json['username'],
      can_join_groups: json['can_join_groups'],
      can_read_all_group_messages: json['can_read_all_group_messages'],
      supports_inline_queries: json['supports_inline_queries'],
      can_connect_to_business: json['can_connect_to_business'],
      has_main_web_app: json['has_main_web_app'],
    );
  }
}

class BotConfigureVerifyResponse {
  final bool ok;
  final Result result;

  BotConfigureVerifyResponse({
    required this.ok,
    required this.result,
  });

  factory BotConfigureVerifyResponse.fromJson(Map<String, dynamic> json) {
    return BotConfigureVerifyResponse(
      ok: json['ok'],
      result: Result.fromJson(json['result']),
    );
  }
}
