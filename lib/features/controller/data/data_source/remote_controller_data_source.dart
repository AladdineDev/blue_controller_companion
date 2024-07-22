import 'package:blue_controller_companion/features/controller/domain/game_config_data_model.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_list_model.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_controller_data_source.g.dart';

@RestApi()
abstract class RemoteControllerDataSource {
  factory RemoteControllerDataSource(Dio dio, {String baseUrl}) =
      _RemoteControllerDataSource;

  @POST("/game-config")
  Future<GameConfig> createGameConfig(
    @Body() GameConfig gameConfig,
  );

  @GET("/game-config")
  Future<GameConfigList> readGameConfigs();

  @GET("/game-config/{id}")
  Future<GameConfigData> readGameConfig(
    @Path("id") String id,
  );

  @PATCH("/game-config/{id}")
  Future<GameConfig> updateGameConfig(
    @Path("id") String id,
    @Body() GameConfig gameConfig,
  );

  @DELETE("/game-config/{id}")
  Future<void> deleteGameConfig(
    @Path("id") String id,
  );
}
