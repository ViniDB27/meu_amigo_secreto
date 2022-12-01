import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'controller/sign_up_controller.dart';
import 'repository/sign_up_repository.dart';
import 'view/sign_up_view.dart';

class SignUpModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<SignUpRepository>((i) => SignUpRepository(i())),
        //controller
        Bind.factory<SignUpController>((i) => SignUpController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChangeNotifierProvider(
            create: (_) => Modular.get<SignUpController>(),
            child: const SignUpView(),
          ),
        ),
      ];
}
