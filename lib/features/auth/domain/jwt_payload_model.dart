import 'package:blue_controller_companion/features/auth/domain/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'jwt_payload_model.freezed.dart';
part 'jwt_payload_model.g.dart';

@freezed
class JwtPayloadModel with _$JwtPayloadModel {
  factory JwtPayloadModel({
    required UserModel? user,
  }) = _JwtPayloadModel;

  factory JwtPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$JwtPayloadModelFromJson(json);
}
