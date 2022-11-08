import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';
import '../repository/home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController(this.repository);
  Future<List<GroupModel>> getMyGroups() async {
    try {
      return repository.getMyGroups();
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
