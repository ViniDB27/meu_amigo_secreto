class FirebaseServiceException implements Exception {
  final String errorCode;

  FirebaseServiceException(this.errorCode);

  final Map<String, String> messages = {
    'email-already-in-use': 'O email já está sendo utilizado',
    'invalid-email': 'O email é inválido',
    'operation-not-allowed': 'Operação não permitida',
    'weak-password': 'A senha é muito fraca',
    'user-not-found': 'Usuário não encontrado',
    'wrong-password': 'Senha incorreta',
  };

  @override
  String toString() => messages[errorCode] ?? 'Erro desconhecido';
}
