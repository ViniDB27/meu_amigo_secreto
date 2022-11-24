import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../model/group_model.dart';
import '../repository/home_repository.dart';

class HomeController with ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository);

  List<GroupModel> _groups = [];
  bool loading = false;

  List<GroupModel> get groups => [..._groups];

  Future<void> getMyGroups(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      _groups = await repository.getMyGroups();
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

  Future<void> signOut(BuildContext context) async {
    try {
      await repository.signOut();
      await Modular.to.pushReplacementNamed(AppRoutes.signIn);
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
