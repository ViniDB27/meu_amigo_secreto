import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/utils/snack_bar.dart';
import '../model/friend_model.dart';
import '../model/group_model.dart';
import '../repository/group_repository.dart';

class GroupController with ChangeNotifier {
  final GroupRepository repository;

  GroupController(this.repository);

  GroupModel? groupModel;
  FriendModel? friendModel;

  List<TextEditingController> suggestionFieldList = [TextEditingController()];
  List<String> friendSuggestions = [];

  bool loading = false;
  bool loadingSortedNames = false;
  bool loadingRemoveMember = false;

  bool isOwner = false;

  initializeStates(
    BuildContext context,
    String id,
  ) async {
    try {
      loading = true;
      notifyListeners();

      await getGroupById(id);
      await getMyFriend();
      await getMySuggestions();
      await isOwnerGroup();
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

  Future<void> isOwnerGroup() async {
    isOwner = await repository.isOwnerGroup(groupModel!.id);
    notifyListeners();
  }

  Future<void> sortedFriends(BuildContext context) async {
    try {
      loadingSortedNames = true;
      notifyListeners();

      await repository.sortedFriends(groupModel!.id);
      await getMyFriend();
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    } finally {
      loadingSortedNames = false;
      notifyListeners();
    }
  }

  Future<void> getGroupById(String id) async {
    try {
      groupModel = await repository.getGroupById(id);
      notifyListeners();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> getMyFriend() async {
    try {
      friendModel = await repository.myFriend(groupModel!.id);

      if (friendModel != null) {
        await getSuggestionsMyFriend();
      }

      notifyListeners();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> getSuggestionsMyFriend() async {
    try {
      final suggestions = await repository.getSuggestionsMyFriend(
        groupId: groupModel!.id,
        friendId: friendModel!.id,
      );

      friendSuggestions = suggestions.map((e) => e.toString()).toList();
      notifyListeners();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> getMySuggestions() async {
    try {
      final suggestions = await repository.getMySuggestions(
        id: groupModel!.id,
      );

      suggestionFieldList = suggestions
          .map((e) => TextEditingController(text: e.toString()))
          .toList();

      notifyListeners();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> saveMySuggestions(BuildContext context) async {
    try {
      await repository.saveMySuggestions(
        id: groupModel!.id,
        suggestions: suggestionFieldList.map((e) => e.text).toList(),
      );
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeMemberGroup({
    required BuildContext context,
    required String memberId,
  }) async {
    try {
      loadingRemoveMember = true;
      notifyListeners();

      await repository.removeMemberGroup(
        groupId: groupModel!.id,
        memberId: memberId,
      );
    } on FirebaseServiceException catch (e) {
      snackBar(
        context: context,
        message: e.toString(),
      );
    } finally {
      loadingRemoveMember = false;
      notifyListeners();
    }
  }

  void addNewField() {
    suggestionFieldList.add(TextEditingController());
    notifyListeners();
  }

  Future<void> removeField(BuildContext context, int hashCode) async {
    suggestionFieldList.removeWhere((element) => element.hashCode == hashCode);
    await saveMySuggestions(context);
    notifyListeners();
  }
}
