import 'package:flutter_modular/flutter_modular.dart';

import 'controller/splash_controller.dart';
import 'repository/splash_repository.dart';
import 'view/splash_view.dart';


class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<SplashRepository>((i) => SplashRepository(i())),
        //controller
        Bind.factory<SplashController>((i) => SplashController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashView()),
      ];
}