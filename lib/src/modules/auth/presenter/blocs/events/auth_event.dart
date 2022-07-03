import '../../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../../domain/usecases/create_user.dart';

abstract class AuthEvent {}

class CreateUserEvent extends AuthEvent {
  final CreateUserCredentials credentials;

  CreateUserEvent(this.credentials);
}

class SignIngWithEmailAndPassword extends AuthEvent {
  final AuthenticateWithEmailAndPasswordCredentials credentials;

  SignIngWithEmailAndPassword(this.credentials);
}

class SignIngWithGoogle extends AuthEvent {}

class SignIngWithApple extends AuthEvent {}