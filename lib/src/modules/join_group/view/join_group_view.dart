import 'package:flutter/material.dart';

import '../../../core/shared/widgets/notification_button_widget.dart';

class JoinGroupView extends StatefulWidget {
  const JoinGroupView({Key? key}) : super(key: key);

  @override
  State<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends State<JoinGroupView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: const [
          NotificationButton(),
        ],
      ),
      body: SizedBox(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: const Center(
          child: Text("Entrar"),
        ),
      ),
    );
  }
}
