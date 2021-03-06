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
  InvalidCredentialException({super.message = "As credenciais de acesso são inválidas"});

  @override
  String toString() {
    return "InvalidCredentialException: $message";
  }
}

class InvalidEmailException extends AuthException {
  InvalidEmailException({super.message = "Email inválido"});

  @override
  String toString() {
    return "InvalidRecoverException: $message";
  }
}
