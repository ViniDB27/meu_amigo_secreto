import 'package:flutter/material.dart';

import '../../../core/shared/theme/app_fonts.dart';

class DrawButton extends StatelessWidget {
  const DrawButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  final bool isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10,
        ),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              'Sortear Nomes',
              style: AppFonts.interNormal(context),
            ),
    );
  }
}
