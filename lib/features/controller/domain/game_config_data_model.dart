import 'package:blue_controller_companion/enums/button_type.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_config_data_model.freezed.dart';
part 'game_config_data_model.g.dart';

typedef ButtonMapping = Map<String, ButtonType>;

@freezed
class GameConfigData with _$GameConfigData {
  factory GameConfigData({
    required GameConfig? data,
    required ButtonMapping? buttonMapping,
  }) = _GameConfigData;

  factory GameConfigData.fromJson(Map<String, dynamic> json) =>
      _$GameConfigDataFromJson(json);
}
