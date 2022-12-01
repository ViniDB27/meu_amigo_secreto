import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignUpController>(context);
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
                  label: 'Nome',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.nameController,
                  fieldValidator: (name) =>
                      controller.nameValidator(name ?? ''),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                TextFieldCustom(
                  label: 'Confirmar Senha',
                  obscureText: true,
                  controller: controller.confirmPasswordController,
                  fieldValidator: (cPassword) =>
                      controller.confirmPasswordValidator(
                    cPassword ?? '',
                    controller.passwordController.text,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.createNewAccount(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          )),
                      child: controller.loading
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
