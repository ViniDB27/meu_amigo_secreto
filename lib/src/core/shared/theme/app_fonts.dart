import 'package:flutter/material.dart';

class AppFonts {
  static TextStyle interNormal(BuildContext context) => TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onPrimaryContainer,
  );
}