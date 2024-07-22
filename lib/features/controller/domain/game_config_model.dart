import 'package:blue_controller_companion/enums/button_type.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_config_model.freezed.dart';
part 'game_config_model.g.dart';

@freezed
class GameConfig with _$GameConfig {
  factory GameConfig({
    required String? id,
    required String? name,
    required ButtonMapping? buttonMapping,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);
}
