import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/member_model.dart';
import 'member_card_widget.dart';

class AllMembers extends StatelessWidget {
  const AllMembers({
    Key? key,
    required this.members,
    this.removeButton = false,
  }) : super(key: key);

  final List<MemberModel> members;
  final bool removeButton;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Text(
          'Todos os Participantes: ${members.length}',
          style: GoogleFonts.itim().copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: mediaQuery.size.width,
          height: 155,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: members.length,
            itemBuilder: (ctx, i) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: MemberCard(
                member: members[i],
                removeButton: removeButton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
