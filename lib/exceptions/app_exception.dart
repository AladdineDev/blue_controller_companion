sealed class AppException implements Exception {
  const AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class UnknownException extends AppException {
  const UnknownException()
      : super(
          'unknown-exception',
          'Oops, something went wrong',
        );
}

class LoginSessionExpired extends AppException {
  LoginSessionExpired()
      : super(
          'login-session-expired',
          "Your session has expired",
        );
}
