import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/utils/alert_dialog.dart';
import '../controller/group_controller.dart';
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
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();

    myBanner.load();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GroupController>(context, listen: false).initializeStates(
        context,
        widget.groupId,
      );
    });
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
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
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 60,
              width: mediaQuery.size.width,
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Center(
                child: AdWidget(
                  ad: myBanner,
                ),
              ),
            ),
            Expanded(
              child: controller.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
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
                              GroupInformation(
                                  groupModel: controller.groupModel),
                              const SizedBox(height: 40),
                              if (controller.isOwner &&
                                  controller.groupModel != null &&
                                  !controller.groupModel!.isDraw &&
                                  controller.groupModel!.members.length > 1)
                                DrawButton(
                                  isLoading: controller.loadingSortedNames,
                                  onPressed: () => alertDialog(
                                    context: context,
                                    title: 'Sortear Nomes',
                                    content:
                                        'Você vai sortear os nomes dos participantes. Deseja continuar?',
                                    onPressedConfirm: () =>
                                        controller.sortedFriends(context),
                                    onPressedCancel: () =>
                                        Navigator.pop(context, 'Cancel'),
                                  ),
                                ),
                              const SizedBox(height: 40),
                              Suggestion(
                                suggestionFieldList:
                                    controller.suggestionFieldList,
                                addNewField: controller.addNewField,
                                removeField: (hashCode) =>
                                    controller.removeField(
                                  context,
                                  hashCode,
                                ),
                                onEditingComplete: () =>
                                    controller.saveMySuggestions(context),
                              ),
                              const SizedBox(height: 20),
                              if (controller.friendModel != null)
                                const YourFriend(),
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
            ),
          ],
        ),
      ),
    );
  }
}
