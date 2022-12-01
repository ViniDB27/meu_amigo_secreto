import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../model/group_model.dart';
import '../repository/edit_group_repository.dart';

class EditGroupController with ChangeNotifier {
  final EditGroupRepository repository;

  EditGroupController(this.repository);

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

  GroupModel? groupModel;

  bool loading = false;

  Future<void> getGroupById(
    BuildContext context,
    String id,
  ) async {
    try {
      loading = true;
      notifyListeners();

      groupModel = await repository.getGroupById(id: id);

      groupModel = groupModel;
      nameController.text = groupModel!.name;
      drawDateController.text = groupModel!.drawDate;
      valueController.text = groupModel!.value;
      eventDateController.text = groupModel!.eventDate;
      eventTimeController.text = groupModel!.eventTime;
      addressController.text = groupModel!.address;
      neighborhoodController.text = groupModel!.neighborhood;
      numberController.text = groupModel!.number;
      cityController.text = groupModel!.city;
      zipCodeController.text = groupModel!.zipCode;
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

  Future<void> editGroup(BuildContext context) async {
    try {
      if (formStateKey.currentState!.validate()) {
        loading = true;
        notifyListeners();

        await repository.editGroup(
          id: groupModel!.id,
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

  Future<void> deleteGroup(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();

      await repository.deleteGroup(groupModel!.id);

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
}
