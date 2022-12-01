import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../model/group_model.dart';
import '../repository/join_group_repository.dart';

class JoinGroupController with ChangeNotifier {
  final JoinGroupRepository repository;

  JoinGroupController(this.repository);

  GroupModel? groupModel;

  bool loading = false;

  Future<void> getGroupById(
    BuildContext context,
    String id,
  ) async {
    try {
      loading = true;
      notifyListeners();

      groupModel = await repository.getGroupById(id);
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

  Future<void> joinGroup(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();

      await repository.joinGroup(groupModel!.id);
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
