import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    this.groupId,
  }) : super(key: key);

  final String? groupId;

  void shareGroup() async {
    await Share.share(
      'Venha participar do nosso Amigo Secreto https://meuamigosecreto.viniciosdb.com.br/?link=https://meuamigosecreto.viniciosdb.com.br/joingroup/?group=$groupId&apn=br.com.viniciosdb.meu_amigo_secreto',
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: shareGroup, icon: const Icon(Icons.share));
  }
}
