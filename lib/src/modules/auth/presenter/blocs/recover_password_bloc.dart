import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/recover_password.dart';

import 'states/auth_state.dart';
import 'events/auth_event.dart';

class RecoverPasswordBloc extends Bloc<AuthEvent, AuthState> {
  final RecoverPassword recoverPassword;

  RecoverPasswordBloc(this.recoverPassword) : super(InitialAuthState()) {
    on<RecoverPasswordEvent>(recoverPasswordMethod);
  }

  Future recoverPasswordMethod(
    RecoverPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 2));

    final result = await recoverPassword(event.email);

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessEmptyAuthState());
    });
  }
}
