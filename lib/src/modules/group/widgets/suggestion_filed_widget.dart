import 'package:flutter/material.dart';

import '../../../core/shared/widgets/text_field_custom_widget.dart';

class SuggestionField extends StatelessWidget {
  const SuggestionField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldCustom(
      label: 'Sua sugestão de presente',
      keyboardType: TextInputType.emailAddress,
      controller: controller,
    );
  }
}