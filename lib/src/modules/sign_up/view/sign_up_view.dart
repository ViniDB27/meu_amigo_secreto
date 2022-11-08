import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_amigo_secreto/src/core/shared/routes/app_routes.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formStateKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final controller = Modular.get<SignUpController>();

  bool isLoading = false;

  void onSignUpButtonPressed() async {
    setState(() => isLoading = true);

    try {
      if (formStateKey.currentState?.validate() == true) {
        await controller.createNewAccount(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

         await Modular.to.pushReplacementNamed(AppRoutes.home);
      }
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final platform = Theme.of(context).platform;

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
            key: formStateKey,
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
                  label: 'Nome',
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  fieldValidator: (name) =>
                      controller.nameValidator(name ?? ''),
                ),
                const SizedBox(height: 10),
                TextFieldCustom(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  fieldValidator: (email) =>
                      controller.emailValidator(email ?? ''),
                ),
                const SizedBox(height: 10),
                TextFieldCustom(
                  label: 'Senha',
                  obscureText: true,
                  controller: passwordController,
                  fieldValidator: (password) =>
                      controller.passwordValidator(password ?? ''),
                ),
                const SizedBox(height: 10),
                TextFieldCustom(
                  label: 'Confirmar Senha',
                  obscureText: true,
                  controller: confirmPasswordController,
                  fieldValidator: (cPassword) =>
                      controller.confirmPasswordValidator(
                    cPassword ?? '',
                    passwordController.text,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onSignUpButtonPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          )),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Cadastrar-se',
                              style: AppFonts.interNormal(context),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  child: Text(
                    'Voltar ao login',
                    style: AppFonts.interNormal(context).copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
