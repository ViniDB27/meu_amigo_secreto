import 'package:flutter/material.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';
import '../repository/home_repository.dart';

class HomeController with ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository);

  List<GroupModel> _groups = [];

  List<GroupModel> get groups => [..._groups];

  Future<void> getMyGroups(BuildContext context) async {
    try {
      _groups = await repository.getMyGroups();
      notifyListeners();
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
