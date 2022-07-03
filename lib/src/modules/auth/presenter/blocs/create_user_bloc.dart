import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_user.dart';

import 'states/auth_state.dart';
import 'events/auth_event.dart';

class CreateUserBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser createUser;

  CreateUserBloc(this.createUser)
      : super(InitialAuthState()) {
    on<CreateUserEvent>(createUserMethod);
  }

  Future createUserMethod(
    CreateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 1));

    final result = await createUser(event.credentials);

    result.fold((error) {
      emit(ErrorAuthState(error.message));
    }, (account) {
      emit(SuccessAuthState(account));
    });
  }
}
