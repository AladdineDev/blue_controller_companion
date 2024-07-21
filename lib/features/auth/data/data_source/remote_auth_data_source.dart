import 'package:blue_controller_companion/features/auth/domain/jwt_response_model.dart';
import 'package:blue_controller_companion/features/auth/domain/login_input_model.dart';
import 'package:blue_controller_companion/features/auth/domain/user_credential_model.dart';
import 'package:blue_controller_companion/features/auth/domain/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'remote_auth_data_source.g.dart';

@RestApi()
abstract class RemoteAuthDataSource {
  factory RemoteAuthDataSource(Dio dio) = _RemoteAuthDataSource;

  @GET("/")
  Future<void> healthCheck();

  @POST("/user/login")
  Future<JwtResponseModel> login(@Body() LoginInputModel loginInputModel);

  @POST("/user")
  Future<UserModel> createUser(@Body() UserCredentialModel userCredentialModel);

  @GET("/user/{id}")
  Future<UserModel> readUser(@Path("id") String id);

  @PATCH("/user")
  Future<UserModel> updateUser(@Body() Map<String, dynamic> updates);

  @POST("/user/logout")
  Future<void> logout();
}
