import 'package:flutter/material.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../model/member_model.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    Key? key,
    required this.member,
  }) : super(key: key);

  final MemberModel member;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(15),
      width: 300,
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
    );
  }
}
