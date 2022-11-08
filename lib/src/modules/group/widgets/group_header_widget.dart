import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/shared/theme/app_images.dart';
import '../model/group_model.dart';

class GroupHeader extends StatelessWidget {
  const GroupHeader({
    Key? key,
    this.groupModel,
  }) : super(key: key);

  final GroupModel? groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          groupModel?.name ?? 'Nome do Grupo',
          style: GoogleFonts.itim().copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 80,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundImage: const AssetImage(AppImages.nica),
        ),
      ],
    );
  }
}
