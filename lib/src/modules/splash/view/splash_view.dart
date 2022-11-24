import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Modular.get<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.verifyIfExistUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(
          top: 200,
          right: 40,
          left: 40,
        ),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                AppImages.nica,
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Meu Amigo Secreto",
              style: AppFonts.interNormal(context).copyWith(
                fontSize: 32,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
