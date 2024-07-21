import 'package:blue_controller_companion/common/provider/dio_client.dart';
import 'package:blue_controller_companion/features/controller/data/data_source/remote_controller_data_source.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller_repository.g.dart';

@riverpod
ControllerRepository controllerRepository(ControllerRepositoryRef ref) {
  return ControllerRepository(
    remoteControllerDataSource: RemoteControllerDataSource(
      ref.watch(dioClientProvider).requireValue,
    ),
  );
}

class ControllerRepository {
  final RemoteControllerDataSource remoteControllerDataSource;

  ControllerRepository({required this.remoteControllerDataSource});

  Future<GameConfig> createGameConfig(GameConfig gameConfig) async {
    return await remoteControllerDataSource.createGameConfig(gameConfig);
  }

  Future<List<GameConfig>> readGameConfigs() async {
    return await remoteControllerDataSource.readGameConfigs();
  }

  Future<GameConfig> readGameConfig(String id) async {
    return await remoteControllerDataSource.readGameConfig(id);
  }

  Future<GameConfig> updateGameConfig(String id, GameConfig gameConfig) async {
    return await remoteControllerDataSource.updateGameConfig(id, gameConfig);
  }

  Future<void> deleteGameConfig(String id) async {
    await remoteControllerDataSource.deleteGameConfig(id);
  }
}
