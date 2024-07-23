import 'package:blue_controller_companion/features/auth/data/repository/user_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<UserModel> user(UserRef ref, {required String id}) {
  return ref.watch(userRepositoryProvider).readUser(id: id);
}
