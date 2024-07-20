import 'package:blue_controller_companion/common/provider/dio_client.dart';
import 'package:blue_controller_companion/features/auth/data/data_source/remote_auth_data_source.dart';
import 'package:blue_controller_companion/features/auth/data/repository/jwt_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/login_input_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    remoteAuthDataSource: RemoteAuthDataSource(
      ref.watch(dioClientProvider).requireValue,
    ),
    jwtRepository: ref.watch(jwtRepositoryProvider),
  );
}

class AuthRepository {
  AuthRepository({
    required this.remoteAuthDataSource,
    required this.jwtRepository,
  });

  final RemoteAuthDataSource remoteAuthDataSource;
  final JwtRepository jwtRepository;

  Future<void> signIn({required LoginInputModel loginInput}) async {
    final jwtResponse = await remoteAuthDataSource.login(loginInput);
    final jwt = jwtResponse.jwt;
    if (jwt == null) throw Exception("No jwt");
    await jwtRepository.createJwt(jwt);
  }

  Future<void> signOut() async {
    await Future.wait([
      remoteAuthDataSource.logout(),
      jwtRepository.deleteJwt(),
    ]);
  }
}
