import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'messages_list_model.freezed.dart';
part 'messages_list_model.g.dart';

@freezed
class MessageListModel with _$MessageListModel {
  factory MessageListModel({
    required MessageListModel? message,
  }) = _MessageListModel;

  factory MessageListModel.fromJson(Map<String, dynamic> json) =>
      _$MessageListModelFromJson(json);
}
