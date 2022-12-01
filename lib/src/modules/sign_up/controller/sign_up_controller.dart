import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../repository/sign_up_repository.dart';

class SignUpController with ChangeNotifier {
  final SignUpRepository repository;

  SignUpController(this.repository);

  final formStateKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  Future<void> createNewAccount(BuildContext context) async {
    try {
      if (formStateKey.currentState!.validate()) {
        await repository.createNewAccount(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
      }

      await Modular.to.pushReplacementNamed(AppRoutes.home);
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
