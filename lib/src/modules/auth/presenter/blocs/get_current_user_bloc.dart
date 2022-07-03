import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_user.dart';

import 'states/auth_state.dart';
import 'events/auth_event.dart';

class GetCurrentUserBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser getCurrentUser;

  GetCurrentUserBloc(this.getCurrentUser)
      : super(InitialAuthState()) {
    on<GetCurrentUserEvent>(getCurrentUserMethod);
  }

  Future getCurrentUserMethod(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 2));

    final result = await getCurrentUser();

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessAuthState(account));
    });
  }
}
