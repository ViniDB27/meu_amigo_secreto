import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final formStateKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final controller = Modular.get<ForgotPasswordController>();

  bool isLoading = false;

  void onForgotPasswordButtonPressed() async {
    setState(() => isLoading = true);

    try {
      if (formStateKey.currentState?.validate() == true) {
        await controller.forgotPassword(
          email: emailController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("E-mail enviado com sucesso!"),
          ),
        );

        Modular.to.pop();
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
                const SizedBox(height: 30),
                Text(
                  "Meu Amigo Secreto",
                  style: AppFonts.interNormal(context).copyWith(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Informe o email de sua conta e enviaremos um link para redefinição de sua senha.",
                  style: AppFonts.interNormal(context),
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  fieldValidator: (email) =>
                      controller.emailValidator(email ?? ''),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onForgotPasswordButtonPressed,
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
                              'Enviar Email',
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
