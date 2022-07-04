import 'package:dartz/dartz.dart';

import '../errors/auth_errors.dart';

abstract class RecoverPassword {
  Future<Either<AuthException, void>> call(String email);
}
