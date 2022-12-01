import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../repository/create_group_repository.dart';

class CreateGroupController with ChangeNotifier {
  final CreateGroupRepository repository;

  CreateGroupController(this.repository);

  final formStateKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final drawDateController = TextEditingController();
  final valueController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();
  final addressController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final numberController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();

  bool loading = false;

  Future<void> createNewGroup(BuildContext context) async {
    try {
      if (formStateKey.currentState!.validate()) {
        loading = true;
        notifyListeners();

        await repository.createNewGroup(
          name: nameController.text,
          drawDate: drawDateController.text,
          value: valueController.text,
          eventDate: eventDateController.text,
          eventTime: eventTimeController.text,
          address: addressController.text,
          neighborhood: neighborhoodController.text,
          number: numberController.text,
          city: cityController.text,
          zipCode: zipCodeController.text,
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

  String? fieldIsNotEmptyValidator(String value) {
    if (value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    return null;
  }
}
