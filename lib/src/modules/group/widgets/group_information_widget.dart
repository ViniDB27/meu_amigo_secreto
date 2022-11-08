import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/group_model.dart';

class GroupInformation extends StatelessWidget {
  const GroupInformation({
    Key? key,
    this.groupModel,
  }) : super(key: key);

  final GroupModel? groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Data: ${groupModel?.eventDate}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              "Hora: ${groupModel?.eventTime}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rua: ${groupModel?.address}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              "Nº: ${groupModel?.number}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bairro: ${groupModel?.neighborhood}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              "Cidade: ${groupModel?.city}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CEP: ${groupModel?.zipCode}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              "Valor: ${groupModel?.value}",
              style: GoogleFonts.inter().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
