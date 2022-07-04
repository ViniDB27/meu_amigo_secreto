import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class SuccessEmptyAuthState extends AuthState {}
class SuccessAuthState extends AuthState {
  final AccountEntity account;

  SuccessAuthState(this.account);
}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState(this.message);
}

class LoadingAuthState extends AuthState {}