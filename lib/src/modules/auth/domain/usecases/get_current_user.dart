import 'package:dartz/dartz.dart';

import '../errors/auth_errors.dart';
import '../entities/account_entity.dart';

abstract class GetCurrentUser {
  Future<Either<AuthException, AccountEntity>> call();
}