import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';

class HomeRepository {
  final FirebaseService firebaseService;

  HomeRepository(this.firebaseService);

  Future<List<GroupModel>> getMyGroups() async {
    try {
      final listGroup = await firebaseService.getMyGroups();

      return listGroup
          .map((group) => GroupModel.fromMap({
                'id': group['id'],
                'name': group['name'],
                'image': group['image'],
                'date': group['eventDate'],
                'members': group['members'].length,
              }))
          .toList();
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
