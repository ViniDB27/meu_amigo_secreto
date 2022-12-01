import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_amigo_secreto/src/core/shared/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../controller/join_group_controller.dart';

class JoinGroupView extends StatefulWidget {
  const JoinGroupView({
    Key? key,
    required this.uri,
  }) : super(key: key);

  final Uri uri;

  @override
  State<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends State<JoinGroupView> {
  @override
  void initState() {
    super.initState();

    if (widget.uri.queryParameters['group'] != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<JoinGroupController>(context, listen: false).getGroupById(
          context,
          widget.uri.queryParameters['group']!,
        );
      });
    } else {
      Modular.to.pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JoinGroupController>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: controller.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            )
          : Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      controller.groupModel?.name ?? 'Nome do Grupo',
                      style: GoogleFonts.itim().copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      backgroundImage: const AssetImage(AppImages.nica),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data: ${controller.groupModel?.eventDate}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Hora: ${controller.groupModel?.eventTime}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rua: ${controller.groupModel?.address}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Nº: ${controller.groupModel?.number}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Bairro: ${controller.groupModel?.neighborhood}",
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Cidade: ${controller.groupModel?.city}",
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CEP: ${controller.groupModel?.zipCode}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Valor: ${controller.groupModel?.value}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    controller.groupModel != null &&
                            controller.groupModel!.isDraw
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Grupo fechado, sorteio realizado",
                                style: GoogleFonts.itim().copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => Modular.to
                                    .pushReplacementNamed(AppRoutes.home),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(
                                  'Recusar',
                                  style: AppFonts.interNormal(context).copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.joinGroup(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(
                                  'Aceitar',
                                  style: AppFonts.interNormal(context),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
