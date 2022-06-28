import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';

abstract class AuthenticateWithEmailAndPassword {
  Future<AccountEntity> auth(
      {required AuthenticateWithEmailAndPasswordParams params});
}

class AuthenticateWithEmailAndPasswordParams {
  final String email;
  final String password;

  AuthenticateWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
