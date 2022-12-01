import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../repository/forgot_password_repository.dart';

class ForgotPasswordController with ChangeNotifier {
  final ForgotPasswordRepository repository;

  ForgotPasswordController(this.repository);

  final formStateKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool loading = false;

  Future<void> forgotPassword(BuildContext context) async {
    try {
      if (formStateKey.currentState!.validate()) {
        loading = true;
        notifyListeners();

        await repository.forgotPassword(
          email: emailController.text,
        );

        snackBar(
          context: context,
          message: "E-mail enviado com sucesso!",
        );

        Modular.to.pop();
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

  String? emailValidator(String value) {
    if (!isEmail(value)) {
      return '* E-mail não é válido';
    }
    return null;
  }
}
