import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/theme/app_fonts.dart';
import '../../../../../shared/theme/app_images.dart';
import '../../../../../shared/theme/app_colors.dart';

import '../../../domain/usecases/authenticate_with_email_and_password.dart';

import '../../../presenter/blocs/authenticate_with_google_bloc.dart';
import '../../../presenter/blocs/authenticate_with_apple_bloc.dart';
import '../../../presenter/blocs/states/auth_state.dart';
import '../../../presenter/blocs/events/auth_event.dart';

import '../../blocs/authenticate_with_email_and_password_bloc.dart';

import 'components/social_button.dart';
import 'helper/auth_helper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authenticateWithEmailAndPasswordBloc =
      Modular.get<AuthenticateWithEmailAndPasswordBloc>();
  final authenticateWithGoogleBloc = Modular.get<AuthenticateWithGoogledBloc>();
  final authenticateWithAppleBloc = Modular.get<AuthenticateWithAppleBloc>();

  _onSigningWithEmailAndPassword(BuildContext context) {
    final credentials = AuthenticateWithEmailAndPasswordCredentials(
      email: emailController.text,
      password: passwordController.text,
    );

    authenticateWithEmailAndPasswordBloc
        .add(SignIngWithEmailAndPassword(credentials));
  }

  _onSigningWithGoogle(BuildContext context) {
    authenticateWithGoogleBloc.add(SignIngWithGoogle());
  }

  _onSigningWithApple(BuildContext context) {
    authenticateWithAppleBloc.add(SignIngWithApple());
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final platform = Theme.of(context).platform;

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                AuthHelper.showForgotPasswordSuccessDialog(
                                    context),
                            child: Text(
                              "Esqueci minha senha!",
                              style: AppFonts.textForgotPassword,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<AuthenticateWithEmailAndPasswordBloc,
                          AuthState>(
                        bloc: authenticateWithEmailAndPasswordBloc,
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
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => _onSigningWithEmailAndPassword(context),
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
                            child: BlocBuilder<
                                AuthenticateWithEmailAndPasswordBloc,
                                AuthState>(
                              bloc: authenticateWithEmailAndPasswordBloc,
                              builder: (context, state) {
                                if (state is LoadingAuthState) {
                                  return const CircularProgressIndicator();
                                }

                                return Text(
                                  "Entrar",
                                  style: AppFonts.textInput.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Criar conta",
                              style: AppFonts.textForgotPassword,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ou",
                        style: AppFonts.textOrAuth,
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<AuthenticateWithGoogledBloc, AuthState>(
                          bloc: authenticateWithGoogleBloc,
                          builder: (context, state) {
                            if (state is ErrorAuthState) {
                              return Text(state.message);
                            }

                            if (state is SuccessAuthState) {
                              Modular.to.pushReplacementNamed('./splash');
                            }

                            return const SizedBox();
                          }),
                      if (platform == TargetPlatform.android)
                        SocialButton(
                          onPress: () => _onSigningWithGoogle(context),
                          text: "Entrar com Google",
                          image: AppImages.google,
                        ),
                      BlocBuilder<AuthenticateWithAppleBloc, AuthState>(
                          bloc: authenticateWithAppleBloc,
                          builder: (context, state) {
                            if (state is ErrorAuthState) {
                              return Text(state.message);
                            }

                            if (state is SuccessAuthState) {
                              Modular.to.pushReplacementNamed('./splash');
                            }

                            return const SizedBox();
                          }),
                      if (platform == TargetPlatform.iOS)
                        SocialButton(
                          text: "Entrar com Apple",
                          image: AppImages.apple,
                          onPress: () => _onSigningWithApple(context),
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
