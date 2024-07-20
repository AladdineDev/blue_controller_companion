import 'package:blue_controller_companion/features/auth/domain/jwt_payload_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'jwt_response_model.freezed.dart';
part 'jwt_response_model.g.dart';

@freezed
class JwtResponseModel with _$JwtResponseModel {
  factory JwtResponseModel({
    required String? jwt,
    required JwtPayloadModel? data,
  }) = _JwtResponseModel;

  factory JwtResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JwtResponseModelFromJson(json);
}
