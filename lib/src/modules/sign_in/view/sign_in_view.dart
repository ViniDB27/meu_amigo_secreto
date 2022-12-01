import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/theme/app_fonts.dart';

import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/sign_in_controller.dart';
import '../widgets/social_button_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context);
    final mediaQuery = MediaQuery.of(context);
    final platform = Theme.of(context).platform;

    final List<Widget> signInActions = [
      TextButton(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          'Esqueci minha senha',
          style: AppFonts.interNormal(context),
        ),
      ),
      ElevatedButton(
        onPressed: () => controller.signInWithEmailAndPassword(context),
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            )),
        child: controller.loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                'Entrar',
                style: AppFonts.interNormal(context),
              ),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          right: 40,
          left: 40,
          bottom: 20,
        ),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formStateKey,
            child: Column(
              children: [
                ClipRRect(
                  child: Image.asset(
                    AppImages.nica,
                    width: platform == TargetPlatform.iOS ? 250 : 200,
                    height: platform == TargetPlatform.iOS ? 250 : 200,
                  ),
                ),
                const SizedBox(height: 40),
                TextFieldCustom(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  fieldValidator: (email) =>
                      controller.emailValidator(email ?? ''),
                ),
                const SizedBox(height: 10),
                TextFieldCustom(
                  label: 'Senha',
                  obscureText: true,
                  controller: controller.passwordController,
                  fieldValidator: (password) =>
                      controller.passwordValidator(password ?? ''),
                ),
                const SizedBox(height: 20),
                if (mediaQuery.size.width >= 400)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: signInActions,
                  ),
                if (mediaQuery.size.width < 400)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: signInActions,
                  ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.signUp);
                  },
                  child: Text(
                    'Criar uma conta',
                    style: AppFonts.interNormal(context),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: mediaQuery.size.width / 2 - 100,
                      height: 1,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'OU',
                      style: AppFonts.interNormal(context).copyWith(
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: mediaQuery.size.width / 2 - 100,
                      height: 1,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (platform == TargetPlatform.iOS)
                      SocialButton(
                        color: const Color(0xFF000000),
                        icon: FontAwesomeIcons.apple,
                        onTap: () => controller.signInWithApple(context),
                      ),
                    if (platform == TargetPlatform.android)
                      SocialButton(
                        color: const Color(0xFFEA4335),
                        icon: FontAwesomeIcons.google,
                        onTap: () => controller.signInWithGoogle(context),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
