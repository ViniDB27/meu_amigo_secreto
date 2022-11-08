import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/widgets/notification_button_widget.dart';
import '../controller/home_controller.dart';
import '../model/group_model.dart';
import '../widgets/group_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<GroupModel> groups = [];

  final controller = Modular.get<HomeController>();

  Future<void> loadGroups() async {
    try {
      final list = await controller.getMyGroups();
      setState(() {
        groups = list;
      });
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

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
        child: RefreshIndicator(
          onRefresh: loadGroups,
          child: ListView.builder(
            itemCount: groups.length,
            itemBuilder: (_, i) => GroupCard(group: groups[i]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed(AppRoutes.createGroup),
        tooltip: 'Criar grupo',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
