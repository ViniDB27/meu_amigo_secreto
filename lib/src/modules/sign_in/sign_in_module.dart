import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'controller/sign_in_controller.dart';
import 'repository/sign_in_repository.dart';
import 'view/sign_in_view.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<SignInRepository>((i) => SignInRepository(i())),
        //controller
        Bind.factory<SignInController>((i) => SignInController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChangeNotifierProvider(
            create: (_) => Modular.get<SignInController>(),
            child: const SignInView(),
          ),
        ),
      ];
}
