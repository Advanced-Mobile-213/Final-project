//import 'dart:developer';

enum BotType { messenger, slack, telegram }

extension BotTypeExtension on BotType {
  String get string {
    switch (this) {
      case BotType.messenger:
        return 'messenger';
      case BotType.slack:
        return 'slack';
      case BotType.telegram:
        return 'telegram';
    }
  }
}

BotType botTypeFromString(String type) {
  switch (type) {
    case 'messenger':
      return BotType.messenger;
    case 'slack':
      return BotType.slack;
    case 'telegram':
      return BotType.telegram;
    default:
      throw Exception('Unknown BotType: $type');
  }
}

String botImage(String type) {
  switch (type) {
    case 'messenger':
      return 'assets/images/messenger.png';
    case 'slack':
      return 'assets/images/slack.png';
    case 'telegram':
      return 'assets/images/telegram.png';
    default:
      throw Exception('Unknown BotType: $type');
  }
}

class MetaData {
  // Common
  final String redirect;
  final String botToken;

  // Telegram
  final String? botName;

  //Slack
  final String? clientId;
  final String? clientSecret;
  final String? signingSecret;

  //Messenger
  final String? pageId;
  final String? appSecret;

  MetaData({
    required this.redirect,
    required this.botToken,
    this.botName,
    this.clientId,
    this.clientSecret,
    this.signingSecret,
    this.pageId,
    this.appSecret,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      redirect: json['redirect'],
      botToken: json['botToken'],
      botName: json['botName'],
      clientId: json['clientId'],
      clientSecret: json['clientSecret'],
      signingSecret: json['signingSecret'],
      pageId: json['pageId'],
      appSecret: json['appSecret'],
    );
  }
}

class BotConfiguration {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String id;
  final BotType type;
  final String? accessToken;
  final MetaData metadata;
  final String assistantId;

  BotConfiguration({
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.id,
    required this.type,
    required this.accessToken,
    required this.metadata,
    required this.assistantId,
  });

  factory BotConfiguration.fromJson(Map<String, dynamic> json) {
    return BotConfiguration(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      id: json['id'],
      type: botTypeFromString(json['type']),
      accessToken: json['accessToken'],
      metadata: MetaData.fromJson(json['metadata']),
      assistantId: json['assistantId'],
    );
  }
}
