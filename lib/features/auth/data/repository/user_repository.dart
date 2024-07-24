import 'package:blue_controller_companion/common/provider/dio_client.dart';
import 'package:blue_controller_companion/features/auth/data/data_source/remote_auth_data_source.dart';
import 'package:blue_controller_companion/features/auth/data/repository/jwt_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/user_credential_model.dart';
import 'package:blue_controller_companion/features/auth/domain/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(
    ref,
    remoteAuthDataSource: RemoteAuthDataSource(
      ref.watch(dioClientProvider).requireValue,
    ),
    jwtRepository: ref.watch(jwtRepositoryProvider),
  );
}

class UserRepository {
  UserRepository(
    this.ref, {
    required this.remoteAuthDataSource,
    required this.jwtRepository,
  });

  final Ref ref;
  final RemoteAuthDataSource remoteAuthDataSource;
  final JwtRepository jwtRepository;

  Future<UserModel> readUser({required String id}) async {
    return remoteAuthDataSource.readUser(id);
  }

  Future<UserModel> createUser({
    required UserCredentialModel userCredential,
  }) async {
    final jwtResponse = await remoteAuthDataSource.createUser(userCredential);
    final jwt = jwtResponse.jwt;
    final user = jwtResponse.data;
    if (jwt == null) throw Exception("No jwt");
    if (user == null) throw Exception("No payload");
    await jwtRepository.createJwt(jwt);
    ref.invalidate(dioClientProvider);
    return user;
  }
}
