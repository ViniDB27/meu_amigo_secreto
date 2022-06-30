class AuthException implements Exception {
  final String message;

  AuthException({
    required this.message,
  });

  @override
  String toString() {
    return "AuthException: $message";
  }
}

class InvalidCredentialException extends AuthException {
  InvalidCredentialException({super.message = "invalid credential error"});

  @override
  String toString() {
    return "InvalidCredentialException: $message";
  }
}
