import 'package:flutter/material.dart';

Future<void> alertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? textButtonConfirm,
  String? textButtonCancel,
  required void Function()? onPressedConfirm,
  required void Function()? onPressedCancel,
}) async =>
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: onPressedCancel,
            child: Text(textButtonCancel ?? 'Cancelar'),
          ),
          TextButton(
            onPressed: onPressedConfirm,
            child: Text(textButtonConfirm ?? 'Confirmar'),
          ),
        ],
      ),
    );
