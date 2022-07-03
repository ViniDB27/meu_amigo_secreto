import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/authenticate_with_apple.dart';

import '../../presenter/blocs/events/auth_event.dart';

import 'states/auth_state.dart';

class AuthenticateWithAppleBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateWithApple authenticateWithApple;

  AuthenticateWithAppleBloc(this.authenticateWithApple)
      : super(InitialAuthState()) {
    on<SignIngWithApple>(signIngWithApple);
  }

  Future signIngWithApple(
    SignIngWithApple event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 1));

    final result = await authenticateWithApple();

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessAuthState(account));
    });
  }
}
