import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../repository/sign_up_repository.dart';

class SignUpController {
  final SignUpRepository repository;

  SignUpController(this.repository);

  Future<void> createNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await repository.createNewAccount(
        name: name,
        email: email,
        password: password,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return '* O nome é obrigatória';
    }
    return null;
  }

  String? emailValidator(String value) {
    if (!isEmail(value)) {
      return '* E-mail não é válido';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return '* A senha é obrigatória';
    }
    return null;
  }

  String? confirmPasswordValidator(String value, String password) {
    if (value != password) {
      return '* As senhas não são iguais';
    }
    return null;
  }
}
