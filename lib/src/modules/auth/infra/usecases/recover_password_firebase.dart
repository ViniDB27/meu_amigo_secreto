import 'package:string_validator/string_validator.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/recover_password.dart';
import '../../domain/errors/auth_errors.dart';

class RecoverPasswordImpl extends RecoverPassword {
  final AuthRepository repository;

  RecoverPasswordImpl(this.repository);

  @override
  Future<Either<AuthException, void>> call(String email) async {
    if(!isEmail(email)) {
      return left(InvalidEmailException());
    }
    
    return repository.recoverPassword(email);
  }
}