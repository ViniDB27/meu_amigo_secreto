import 'package:flutter/material.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../model/friend_model.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.friend,
    required this.suggestion,
  }) : super(key: key);

  final FriendModel friend;

  final List<dynamic> suggestion;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.all(15),
      width: mediaQuery.size.width - 60,
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
                          friend.name,
                          style: AppFonts.interNormal(context),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Sugestões:",
                          style: AppFonts.interNormal(context),
                        ),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: ListView.builder(
                            itemCount: suggestion.length,
                            itemBuilder: (context, index) {
                              return Text(
                                suggestion[index],
                                style: AppFonts.interNormal(context),
                              );
                            },
                          ),
                        )
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
