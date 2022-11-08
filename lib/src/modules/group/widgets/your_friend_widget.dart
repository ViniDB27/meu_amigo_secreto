import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class YourFriend extends StatelessWidget {
  const YourFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Seu Amigo Secreto é:',
      style: GoogleFonts.itim().copyWith(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
