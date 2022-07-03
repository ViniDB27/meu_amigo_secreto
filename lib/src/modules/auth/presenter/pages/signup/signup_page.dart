import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/theme/app_fonts.dart';
import '../../../../../shared/theme/app_images.dart';

import '../../../domain/usecases/create_user.dart';

import '../../blocs/states/auth_state.dart';
import '../../blocs/create_user_bloc.dart';
import '../../blocs/events/auth_event.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final createUserBloc = Modular.get<CreateUserBloc>();

  _onCreateUser() {
    final credentials = CreateUserCredentials(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    createUserBloc.add(CreateUserEvent(credentials));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  AppImages.logo,
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 50),
              Form(
                child: Container(
                  color: Colors.transparent,
                  width: 300,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: AppFonts.textInput,
                        decoration: InputDecoration(
                          hintText: 'Nome',
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
                      ),
                      const SizedBox(height: 10),
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
                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        style: AppFonts.textInput,
                        decoration: InputDecoration(
                          hintText: 'Senha',
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
                      ),
                      const SizedBox(height: 60),
                      BlocBuilder<CreateUserBloc, AuthState>(
                        bloc: createUserBloc,
                        builder: (context, state) {
                          if (state is ErrorAuthState) {
                            return Text(state.message);
                          }

                          if (state is SuccessAuthState) {
                            Modular.to.pushReplacementNamed('./splash');
                          }

                          return const SizedBox();
                        },
                      ),
                      InkWell(
                        onTap: _onCreateUser,
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
                            child: BlocBuilder<CreateUserBloc, AuthState>(
                              bloc: createUserBloc,
                              builder: (context, state) {
                                if (state is LoadingAuthState) {
                                  return const CircularProgressIndicator();
                                }

                                return Text(
                                  "Criar conta",
                                  style: AppFonts.textInput.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
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
    );
  }
}
