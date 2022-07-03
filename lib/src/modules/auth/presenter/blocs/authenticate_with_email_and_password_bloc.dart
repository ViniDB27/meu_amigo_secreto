import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meu_amigo_secreto/src/modules/auth/presenter/blocs/events/auth_event.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';

import 'states/auth_state.dart';

class AuthenticateWithEmailAndPasswordBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateWithEmailAndPassword authenticateWithEmailAndPassword;

  AuthenticateWithEmailAndPasswordBloc(this.authenticateWithEmailAndPassword)
      : super(InitialAuthState()) {
    on<SignIngWithEmailAndPassword>(signIngWithEmailAndPassword);
  }

  Future signIngWithEmailAndPassword(
    SignIngWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 1));

    final result = await authenticateWithEmailAndPassword(event.credentials);

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessAuthState(account));
    });
  }
}
