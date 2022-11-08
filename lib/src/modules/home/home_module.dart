import 'package:flutter_modular/flutter_modular.dart';

import 'controller/home_controller.dart';
import 'repository/home_repository.dart';
import 'view/home_view.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<HomeRepository>((i) => HomeRepository(i())),
        //controller
        Bind.factory<HomeController>((i) => HomeController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeView()),
      ];
}
