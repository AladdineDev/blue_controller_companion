import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'server_message_model.freezed.dart';
part 'server_message_model.g.dart';

@freezed
class ServerMessageModel with _$ServerMessageModel {
  factory ServerMessageModel({
    required String type,
    required String message,
    String? title,
  }) = _ServerMessageModel;

  factory ServerMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ServerMessageModelFromJson(json);
}
