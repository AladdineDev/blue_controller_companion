import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_credential_model.freezed.dart';
part 'user_credential_model.g.dart';

@freezed
class UserCredentialModel with _$UserCredentialModel {
  factory UserCredentialModel({
    required String? email,
    required String? username,
    required String? password,
  }) = _UserCredentialModel;

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialModelFromJson(json);
}
