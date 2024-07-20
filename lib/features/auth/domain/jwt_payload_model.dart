import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'jwt_payload_model.freezed.dart';
part 'jwt_payload_model.g.dart';

@freezed
class JwtPayloadModel with _$JwtPayloadModel {
  factory JwtPayloadModel({
    required String? id,
    required String? email,
    required int? iat,
    required int? exp,
  }) = _JwtPayloadModel;

  factory JwtPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$JwtPayloadModelFromJson(json);
}
