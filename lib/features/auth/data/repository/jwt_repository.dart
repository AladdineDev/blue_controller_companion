import 'package:blue_controller_companion/features/auth/data/data_source/local_jwt_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jwt_repository.g.dart';

@Riverpod(keepAlive: true)
JwtRepository jwtRepository(JwtRepositoryRef ref) {
  return JwtRepository(
    ref.watch(localJwtDataSourceProvider),
  );
}

class JwtRepository {
  JwtRepository(this.localJwtDataSource);

  final LocalJwtDataSource localJwtDataSource;

  Future<void> createJwt(String jwt) async {
    await localJwtDataSource.createJwt(jwt: jwt);
  }

  Future<String?> readJwt() async {
    return await localJwtDataSource.readJwt();
  }

  Future<void> deleteJwt() async {
    await localJwtDataSource.deleteJwt();
  }
}
