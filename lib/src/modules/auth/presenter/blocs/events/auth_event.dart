import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';

abstract class AuthEvent {}

class SignIngWithEmailAndPassword extends AuthEvent {
  final AuthenticateWithEmailAndPasswordCredentials credentials;

  SignIngWithEmailAndPassword(this.credentials);
}

class SignIngWithGoogle extends AuthEvent {}

class SignIngWithApple extends AuthEvent {}