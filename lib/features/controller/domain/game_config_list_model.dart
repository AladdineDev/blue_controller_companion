import 'package:blue_controller_companion/features/controller/domain/game_config_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_config_list_model.freezed.dart';
part 'game_config_list_model.g.dart';

@freezed
class GameConfigList with _$GameConfigList {
  factory GameConfigList({
    required List<GameConfig> data,
  }) = _GameConfigList;

  factory GameConfigList.fromJson(Map<String, dynamic> json) =>
      _$GameConfigListFromJson(json);
}
