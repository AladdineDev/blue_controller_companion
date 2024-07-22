import 'package:blue_controller_companion/common/provider/dio_client.dart';
import 'package:blue_controller_companion/features/auth/data/data_source/remote_auth_data_source.dart';
import 'package:blue_controller_companion/features/auth/data/repository/jwt_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/login_input_model.dart';
import 'package:blue_controller_companion/features/auth/domain/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    ref,
    remoteAuthDataSource: RemoteAuthDataSource(
      ref.watch(dioClientProvider).requireValue,
    ),
    jwtRepository: ref.watch(jwtRepositoryProvider),
  );
}

class AuthRepository {
  AuthRepository(
    this.ref, {
    required this.remoteAuthDataSource,
    required this.jwtRepository,
  });

  final Ref ref;
  final RemoteAuthDataSource remoteAuthDataSource;
  final JwtRepository jwtRepository;

  Future<UserModel> signIn({required LoginInputModel loginInput}) async {
    final jwtResponse = await remoteAuthDataSource.login(loginInput);
    final jwt = jwtResponse.jwt;
    final user = jwtResponse.data;
    if (jwt == null) throw Exception("No jwt");
    if (user == null) throw Exception("No payload");
    await jwtRepository.createJwt(jwt);
    ref.invalidateSelf();
    return user;
  }

  Future<void> signOut() async {
    await Future.wait([
      remoteAuthDataSource.logout(),
      jwtRepository.deleteJwt(),
    ]);
    ref.invalidateSelf();
  }

  Future<UserModel> readUser({required String id}) async {
    return remoteAuthDataSource.readUser(id);
  }
}
