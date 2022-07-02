import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/errors/auth_errors.dart';

import '../states/auth_state.dart';

class AuthenticateWithEmailAndPasswordBloc
    extends Bloc<AuthenticateWithEmailAndPasswordCredentials, AuthState> {
  final AuthenticateWithEmailAndPassword authenticateWithEmailAndPassword;

  AuthenticateWithEmailAndPasswordBloc(this.authenticateWithEmailAndPassword)
      : super(InitialAuthState());

  Stream<AuthState> mapEventToState(
    AuthenticateWithEmailAndPasswordCredentials credentials,
  ) async* {
    yield LoadingAuthState();

    try {
      final result = await authenticateWithEmailAndPassword(credentials);
      final newState = result.fold((error) {
        throw error;
      }, (account) {
        return account;
      });

      yield SuccessAuthState(newState);
    } on AuthException catch (error) {
      yield ErrorAuthState(error.toString());
    }
  }
}
