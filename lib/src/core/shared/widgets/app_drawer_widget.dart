import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modules/home/controller/home_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            title: const Text('Meu Amigo Secreto'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<HomeController>(
                context,
                listen: false,
              ).signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
