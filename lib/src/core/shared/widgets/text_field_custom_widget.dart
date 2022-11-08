import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_fonts.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const TextFieldCustom({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.fieldValidator,
    this.inputFormatters,
  }) : super(key: key);

  final String? Function(String?)? fieldValidator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: fieldValidator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        label: Text(
          label,
          style: AppFonts.interNormal(context),
        ),
      ),
      style: AppFonts.interNormal(context),
    );
  }
}
