import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../repository/forgot_password_repository.dart';

class ForgotPasswordController {
  final ForgotPasswordRepository repository;

  ForgotPasswordController(this.repository);

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await repository.forgotPassword(
        email: email,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  String? emailValidator(String value) {
    if (!isEmail(value)) {
      return '* E-mail não é válido';
    }
    return null;
  }
}
