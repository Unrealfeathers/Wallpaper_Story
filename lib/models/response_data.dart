import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class ResponseData {
  const ResponseData({
    required this.code,
    required this.message,
    required this.data,
  });

  final bool code;
  final String message;
  final dynamic data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
      code: json['code'] as bool,
      message: json['message'].toString(),
      data: json['data']);

  Map<String, dynamic> toJson() =>
      {'code': code, 'message': message, 'data': data};

  ResponseData clone() =>
      ResponseData(code: code, message: message, data: data);

  ResponseData copyWith({bool? code, String? message, String? data}) =>
      ResponseData(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseData &&
          code == other.code &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}
