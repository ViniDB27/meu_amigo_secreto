import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../controller/group_controller.dart';
import '../model/friend_model.dart';
import '../model/group_model.dart';
import '../widgets/all_members_widget.dart';
import '../widgets/draw_button_widget.dart';
import '../widgets/edit_button_widget.dart';
import '../widgets/friend_card_widget.dart';
import '../widgets/group_header_widget.dart';
import '../widgets/group_information_widget.dart';
import '../widgets/share_button_widget.dart';
import '../widgets/suggestion_widget.dart';
import '../widgets/your_friend_widget.dart';

class GroupView extends StatefulWidget {
  const GroupView({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  final controller = Modular.get<GroupController>();

  bool isDrawLoading = false;
  bool isLoading = false;
  bool isOwner = false;

  List<TextEditingController> suggestionFieldList = [TextEditingController()];
  List<dynamic> friendSuggestions = [];

  GroupModel? groupModel;
  FriendModel? friend;

  void loadFriend() async {
    try {
      final myFriend = await controller.myFriend(id: widget.groupId);
      setState(() {
        friend = myFriend;
      });

      if (myFriend != null) loadFriendSuggestion();
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void addNewField() {
    final suggestController = TextEditingController();

    setState(() {
      suggestionFieldList.add(suggestController);
    });
  }

  void saveMySuggestions() {
    controller.saveMySuggestions(
      id: widget.groupId,
      suggestions: suggestionFieldList
          .map((e) => e.text)
          .where((element) => element.isNotEmpty)
          .toList(),
    );
  }

  void removeField(int hashCode) {
    suggestionFieldList.removeWhere((element) => element.hashCode == hashCode);
    saveMySuggestions();
    setState(() {});
  }

  void loadSuggestions() async {
    try {
      final suggestions = await controller.getMySuggestions(id: widget.groupId);
      setState(() {
        suggestionFieldList = suggestions
            .map((e) => TextEditingController(text: e.toString()))
            .toList();
      });
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> loadGroupData() async {
    try {
      setState(() => isLoading = true);
      final group = await controller.getGroupById(id: widget.groupId);
      setState(() {
        groupModel = group;
      });
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  verifyOwner() async {
    try {
      final isOwnerGroup = await controller.isOwnerGroup(id: widget.groupId);
      setState(() {
        isOwner = isOwnerGroup;
      });
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void sortedFriends() async {
    try {
      setState(() => isDrawLoading = true);
      await controller.sortedFriends(id: widget.groupId);
      loadAllData();
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() => isDrawLoading = false);
    }
  }

  void loadFriendSuggestion() async {
    if (friend != null && groupModel != null) {
      final suggestions = await controller.getSuggestionsMyFriend(
        friendId: friend!.id,
        groupId: groupModel!.id,
      );

      setState(() {
        friendSuggestions = suggestions;
      });
    }
  }

  Future<void> loadAllData() async {
    loadGroupData();
    verifyOwner();
    loadFriend();
    loadSuggestions();
  }

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          if (isOwner) ShareButton(groupId: widget.groupId),
          if (isOwner) EditButton(id: widget.groupId),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: RefreshIndicator(
                onRefresh: loadAllData,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GroupHeader(groupModel: groupModel),
                      const SizedBox(height: 40),
                      GroupInformation(groupModel: groupModel),
                      const SizedBox(height: 40),
                      if (isOwner &&
                          groupModel != null &&
                          !groupModel!.isDraw &&
                          groupModel!.members.length > 1)
                        DrawButton(
                          isLoading: isDrawLoading,
                          onPressed: sortedFriends,
                        ),
                      const SizedBox(height: 40),
                      Suggestion(
                        suggestionFieldList: suggestionFieldList,
                        addNewField: addNewField,
                        removeField: removeField,
                        onEditingComplete: saveMySuggestions,
                      ),
                      const SizedBox(height: 20),
                      if (friend != null) const YourFriend(),
                      const SizedBox(height: 20),
                      if (friend != null)
                        FriendCard(
                          friend: friend!,
                          suggestion: friendSuggestions,
                        ),
                      const SizedBox(height: 40),
                      AllMembers(members: groupModel?.members ?? []),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
