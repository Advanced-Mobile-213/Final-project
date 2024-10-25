

import 'dart:convert';
import 'dart:typed_data';

class AppUtils {
  static Uint8List bytesFromBase64String(String base64ImageString) {
    String base64string = base64ImageString.split(',').last;
    Uint8List bytes = base64Decode(base64string);
    return bytes;
  }
}