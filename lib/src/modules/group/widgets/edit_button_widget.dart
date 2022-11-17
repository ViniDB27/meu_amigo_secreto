import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/shared/routes/app_routes.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          Modular.to.pushNamed(AppRoutes.editGroup, arguments: id),
      icon: const Icon(Icons.edit),
    );
  }
}
