import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/utils/alert_dialog.dart';
import '../controller/group_controller.dart';
import '../model/member_model.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    Key? key,
    required this.member,
    this.removeButton = false,
  }) : super(key: key);

  final MemberModel member;
  final bool removeButton;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GroupController>(context);

    return Container(
      padding: const EdgeInsets.all(15),
      width: 300,
      height: 155,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: Theme.of(context).colorScheme.background,
                backgroundImage: const AssetImage(AppImages.nica),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.name,
                              style: AppFonts.interNormal(context),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (removeButton)
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () => alertDialog(
                  context: context,
                  title: 'Remover Participante',
                  content: 'Deseja realmente remover o participante do grupo?',
                  onPressedConfirm: () async {
                    await controller.removeMemberGroup(
                      context: context,
                      memberId: member.id,
                    );
                  },
                  onPressedCancel: () => Navigator.pop(context, 'Cancel'),
                ),
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
