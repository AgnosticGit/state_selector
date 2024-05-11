import 'package:flutter/foundation.dart';

@immutable
class Failure {
  const Failure(this.code, this.message);

  final int code;
  final String message;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
