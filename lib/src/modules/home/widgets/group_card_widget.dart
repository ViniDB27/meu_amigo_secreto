import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../model/group_model.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return InkWell(
      onTap: () => Modular.to.pushNamed(AppRoutes.group, arguments: group.id),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: const EdgeInsets.all(15),
        width: queryData.size.width - 40,
        height: 155,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
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
                            group.name,
                            style: AppFonts.interNormal(context),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Membros: ${group.members}",
                            style: AppFonts.interNormal(context),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Data: ${group.date}",
                            style: AppFonts.interNormal(context),
                          ),
                        ],
                      ),
                    ],
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
