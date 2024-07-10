import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

class AuthRepository {
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    //TODO: implement this method
  }

  Future<void> reSignIn() async {
    //TODO: implement this method
  }
}
