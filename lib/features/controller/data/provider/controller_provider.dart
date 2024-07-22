import 'package:blue_controller_companion/features/controller/data/repository/controller_repository.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_data_model.dart';
import 'package:blue_controller_companion/features/controller/domain/game_config_list_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller_provider.g.dart';

@riverpod
Future<GameConfigList> controllers(ControllersRef ref) {
  return ref.watch(controllerRepositoryProvider).readGameConfigs();
}

@riverpod
Future<GameConfigData> controller(ControllerRef ref, {required String id}) {
  return ref.watch(controllerRepositoryProvider).readGameConfig(id);
}
