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
      'Venha participar do nosso Amigo Secreto https://example$groupId.com',
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: shareGroup, icon: const Icon(Icons.share));
  }
}
