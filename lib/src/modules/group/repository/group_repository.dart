import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/friend_model.dart';
import '../model/group_model.dart';
import '../model/member_model.dart';

class GroupRepository {
  final FirebaseService firebaseService;

  GroupRepository(this.firebaseService);

  Future<GroupModel> getGroupById({
    required String id,
  }) async {
    try {
      final groupMap = await firebaseService.getGroupById(id);

      return GroupModel.fromMap(groupMap);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<bool> isOwnerGroup({
    required String id,
  }) async {
    try {
      final user = await firebaseService.getCurrentUser();

      final groupModel = await getGroupById(id: id);

      if (user?['id'] == groupModel.owner.id) {
        return true;
      }

      return false;
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<MemberModel> getIHowMember({
    required String id,
  }) async {
    try {
      final user = await firebaseService.getCurrentUser();

      final groupMap = await firebaseService.getGroupById(id);
      final groupModel = GroupModel.fromMap(groupMap);

      return groupModel.members.firstWhere(
        (member) => member.id == user?['id'],
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<MemberModel> getMyFriendHowMember({
    required String groupId,
    required String friendId,
  }) async {
    try {
      final groupMap = await firebaseService.getGroupById(groupId);
      final groupModel = GroupModel.fromMap(groupMap);

      return groupModel.members.firstWhere((member) => member.id == friendId);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<FriendModel?> myFriend({
    required String id,
  }) async {
    try {
      final friendMember = await getIHowMember(id: id);

      return friendMember.friend;
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<List<dynamic>> getMySuggestions({
    required String id,
  }) async {
    try {
      final member = await getIHowMember(id: id);

      return member.suggestions;
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<List<dynamic>> getSuggestionsMyFriend({
    required String groupId,
    required String friendId,
  }) async {
    try {
      final friendMember = await getMyFriendHowMember(
        groupId: groupId,
        friendId: friendId,
      );

      return friendMember.suggestions;
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> saveMySuggestions({
    required String id,
    required List<String> suggestions,
  }) async {
    try {
      await firebaseService.saveMySuggestions(
        id: id,
        suggestions: suggestions,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> sortedFriends({
    required String id,
  }) async {
    try {
      await firebaseService.sortedFriends(id);
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
