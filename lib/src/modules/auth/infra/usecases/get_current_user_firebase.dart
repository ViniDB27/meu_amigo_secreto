import 'package:dartz/dartz.dart';

import '../../domain/usecases/get_current_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

class GetCurrentUserImpl extends GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUserImpl(this.repository);

  @override
  Future<Either<AuthException, AccountEntity>> call() async {
    return repository.getCurrentUser();
  }
}
