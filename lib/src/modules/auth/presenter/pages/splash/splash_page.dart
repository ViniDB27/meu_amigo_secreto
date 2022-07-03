import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/theme/app_fonts.dart';
import '../../../../../shared/theme/app_images.dart';
import '../../../../../shared/theme/app_colors.dart';

import '../../blocs/events/auth_event.dart';
import '../../blocs/states/auth_state.dart';
import '../../blocs/get_current_user_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final getCurrentUserBloc = Modular.get<GetCurrentUserBloc>();

  @override
  void initState() {
    super.initState();
    getCurrentUserBloc.add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: queryData.size.width,
        height: queryData.size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                AppImages.logo,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Meu Amigo Secreto",
              style: AppFonts.textOrAuth.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black,
              ),
            ),
            BlocBuilder<GetCurrentUserBloc, AuthState>(
              bloc: getCurrentUserBloc,
              builder: (context, state) {
                if (state is ErrorAuthState) {
                  Modular.to.pushReplacementNamed('./signin');
                }

                if (state is SuccessAuthState) {
                  Modular.to.pushReplacementNamed('./signup');
                }

                return const SizedBox(height: 100);
              },
            ),
          ],
        ),
      ),
    );
  }
}
