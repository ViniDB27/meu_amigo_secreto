import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meu_amigo_secreto/src/modules/auth/presenter/blocs/events/auth_event.dart';

import '../../domain/usecases/authenticate_with_google.dart';

import 'states/auth_state.dart';

class AuthenticateWithGoogledBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateWithGoogle authenticateWithGoogle;

  AuthenticateWithGoogledBloc(this.authenticateWithGoogle)
      : super(InitialAuthState()) {
    on<SignIngWithGoogleEvent>(signIngWithGoogle);
  }

  Future signIngWithGoogle(
    SignIngWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 1));

    final result = await authenticateWithGoogle();

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessAuthState(account));
    });
  }
}
