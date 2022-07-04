import '../../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../../domain/usecases/create_user.dart';

abstract class AuthEvent {}

class CreateUserEvent extends AuthEvent {
  final CreateUserCredentials credentials;

  CreateUserEvent(this.credentials);
}

class SignIngWithEmailAndPasswordEvent extends AuthEvent {
  final AuthenticateWithEmailAndPasswordCredentials credentials;

  SignIngWithEmailAndPasswordEvent(this.credentials);
}

class SignIngWithGoogleEvent extends AuthEvent {}

class SignIngWithAppleEvent extends AuthEvent {}

class GetCurrentUserEvent extends AuthEvent {}

class RecoverPasswordEvent extends AuthEvent {
  final String email;

  RecoverPasswordEvent(this.email);
}