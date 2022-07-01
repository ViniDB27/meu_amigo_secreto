import 'package:flutter/material.dart';

import '../../../../shared/theme/app_fonts.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../../shared/theme/app_colors.dart';

import '../components/social_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    Future<void> _forgotPasswordSucess() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Recuperação de senha'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Enviamos um email com o link para recuperar a sua senha.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _authError(Exception error) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Credenciais Inválidas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Email ou Senha estão incorretas.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Tentares Novamente'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                            onPressed: _forgotPasswordSucess,
                            child: Text(
                              "Esqueci minha senha!",
                              style: AppFonts.textForgotPassword,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
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
                            child: Text(
                              "Entrar",
                              style: AppFonts.textInput.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
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
                      const SizedBox(height: 20),
                      SocialButton(
                        text: "Entrar com Google",
                        image: AppImages.google,
                        onPress: () {},
                      ),
                      const SizedBox(height: 10),
                      SocialButton(
                        text: "Entrar com Apple",
                        image: AppImages.apple,
                        onPress: () {},
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
