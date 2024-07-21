import 'package:blue_controller_companion/enums/controller_button_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_config_model.freezed.dart';
part 'game_config_model.g.dart';

@freezed
class GameConfig with _$GameConfig {
  factory GameConfig({
    required String name,
    required Map<String, ButtonType> buttonMapping,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);
}
