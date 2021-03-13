

import 'dart:core';

class SessionHolder {
  static final SessionHolder _singleton = SessionHolder._internal();

  factory SessionHolder() {
    return _singleton;
  }

  SessionHolder._internal();

  String? uid;
  String? acessToken;
  String? client;
}