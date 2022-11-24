import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../repository/sign_in_repository.dart';

class SignInController {
  final SignInRepository repository;

  SignInController(this.repository);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
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

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return '* A senha é obrigatória';
    }
    return null;
  }

  Future<void> signInWithGoogle() async {
    try {
      await repository.signInWithGoogle();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    try {
      await repository.signInWithApple();
    } on FirebaseServiceException {
      rethrow;
    }
  }

}
