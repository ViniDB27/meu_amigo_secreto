import 'package:flutter/material.dart';

import '../../../../domain/errors/auth_errors.dart';

class AuthHelper {
  static Future<void> showForgotPasswordSuccessDialog(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recuperação de senha'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Enviamos um email com o link para recuperar a sua senha.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAuthErrorDialog({
    required AuthException error,
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_getTitleShowAuthError(error)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tentares Novamente'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static String _getTitleShowAuthError(AuthException error) {
    if (AuthException is InvalidCredentialException) {
      return 'Credenciais inválidas';
    } else {
      return 'Falha na autenticação';
    }
  }
}
