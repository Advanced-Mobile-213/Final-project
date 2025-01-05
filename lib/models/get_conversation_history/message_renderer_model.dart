import 'package:flutter/material.dart';

class MessageRendererModel {
  final String content;
  final bool isUserMessage;
  IconData? icon;

  MessageRendererModel({
    required this.content, 
    required this.isUserMessage, 
    this.icon
  });
}