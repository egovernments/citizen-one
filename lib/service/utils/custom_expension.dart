

import 'package:edge_client/service/utils/model.dart';

class CustomException implements Exception {
  final String message;
  final int statusCode;
  final ExceptionType exceptionType;
  final String? code;

  CustomException(this.message, this.statusCode, this.exceptionType,
      {this.code});

  String toString() {
    return "$message";
  }
}
