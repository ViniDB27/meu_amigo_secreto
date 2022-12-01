import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GroupController>(context, listen: false).initializeStates(
        context,
        widget.groupId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GroupController>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          ShareButton(groupId: widget.groupId),
          if (controller.isOwner) EditButton(id: widget.groupId),
        ],
      ),
      body: controller.loading
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
                onRefresh: () => controller.initializeStates(
                  context,
                  widget.groupId,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GroupHeader(groupModel: controller.groupModel),
                      const SizedBox(height: 40),
                      GroupInformation(groupModel: controller.groupModel),
                      const SizedBox(height: 40),
                      if (controller.isOwner &&
                          controller.groupModel != null &&
                          !controller.groupModel!.isDraw &&
                          controller.groupModel!.members.length > 1)
                        DrawButton(
                          isLoading: controller.loadingSortedNames,
                          onPressed: () => controller.sortedFriends(context),
                        ),
                      const SizedBox(height: 40),
                      Suggestion(
                        suggestionFieldList: controller.suggestionFieldList,
                        addNewField: controller.addNewField,
                        removeField: (hashCode) => controller.removeField(
                          context,
                          hashCode,
                        ),
                        onEditingComplete: () =>
                            controller.saveMySuggestions(context),
                      ),
                      const SizedBox(height: 20),
                      if (controller.friendModel != null) const YourFriend(),
                      const SizedBox(height: 20),
                      if (controller.friendModel != null)
                        FriendCard(
                          friend: controller.friendModel!,
                          suggestion: controller.friendSuggestions,
                        ),
                      const SizedBox(height: 40),
                      AllMembers(
                        members: controller.groupModel?.members ?? [],
                        removeButton: controller.isOwner,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
