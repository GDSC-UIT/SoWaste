import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

extension GetScreenHeight on BuildContext {
  double get screenHeight => size!.height;
}

extension GetScreenWidth on BuildContext {
  double get screenHeight => size!.width;
}

extension IsOk on http.Response {
  bool get isOk {
    return (statusCode ~/ 100) == 2;
  }
}

extension GetMessage on http.Response {
  String get message {
    return jsonDecode(body)['message'] ?? 'Something went wrong';
  }
}

extension GetData on http.Response {
  dynamic get data {
    return jsonDecode(body)['data'];
  }
}
