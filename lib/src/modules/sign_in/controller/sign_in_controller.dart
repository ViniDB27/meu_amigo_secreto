import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../repository/sign_in_repository.dart';

class SignInController with ChangeNotifier {
  final SignInRepository repository;

  SignInController(this.repository);

  final formStateKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      if (formStateKey.currentState!.validate()) {
        loading = true;
        notifyListeners();
        await repository.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await Modular.to.pushReplacementNamed(AppRoutes.home);
      }
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await repository.signInWithGoogle();
      await Modular.to.pushReplacementNamed(AppRoutes.home);
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      await repository.signInWithApple();
      await Modular.to.pushReplacementNamed(AppRoutes.home);
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
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
}
