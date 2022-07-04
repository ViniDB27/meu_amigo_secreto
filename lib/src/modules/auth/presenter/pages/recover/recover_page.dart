import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_amigo_secreto/src/modules/auth/presenter/blocs/events/auth_event.dart';
import 'package:meu_amigo_secreto/src/modules/auth/presenter/blocs/recover_password_bloc.dart';
import 'package:meu_amigo_secreto/src/modules/auth/presenter/blocs/states/auth_state.dart';

import '../../../../../shared/theme/app_fonts.dart';
import '../../../../../shared/theme/app_images.dart';
import '../../../../../shared/theme/app_colors.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({Key? key}) : super(key: key);

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final emailController = TextEditingController();

  final recoverPasswordBloc = Modular.get<RecoverPasswordBloc>();

  void _onRecoverPassword() {
    recoverPasswordBloc.add(RecoverPasswordEvent(emailController.text));
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
        child: SingleChildScrollView(
          child: Container(
            height: queryData.size.height,
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
                const SizedBox(height: 30),
                Text(
                  "Informe o email de sua conta e enviaremos um\n link por email para recuperar sua senha.",
                  style: AppFonts.textForgotPassword,
                ),
                const SizedBox(height: 20),
                BlocBuilder<RecoverPasswordBloc, AuthState>(
                  bloc: recoverPasswordBloc,
                  builder: (context, state) {
                    if (state is ErrorAuthState) {
                      return Text(state.message);
                    }

                    if (state is SuccessEmptyAuthState) {
                      return const Text('Email enviado.');
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20),
                Form(
                  child: Container(
                    color: Colors.transparent,
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          style: AppFonts.textInput,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: _onRecoverPassword,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.textGrey,
                                width: 1,
                              ),
                            ),
                            width: double.infinity,
                            height: 56,
                            child: Center(
                              child:
                                  BlocBuilder<RecoverPasswordBloc, AuthState>(
                                bloc: recoverPasswordBloc,
                                builder: (context, state) {
                                  if (state is LoadingAuthState) {
                                    return const CircularProgressIndicator();
                                  }

                                  return Text(
                                    "Enviar e-mail",
                                    style: AppFonts.textInput.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: Text(
                                "Voltar ao login",
                                style: AppFonts.textForgotPassword.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
