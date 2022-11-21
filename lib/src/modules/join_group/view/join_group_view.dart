import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_amigo_secreto/src/core/shared/routes/app_routes.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../controller/join_group_controller.dart';
import '../model/group_model.dart';

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
  final controller = Modular.get<JoinGroupController>();

  bool isLoading = false;

  GroupModel? groupModel;

  Future<void> loadGroupData() async {
    try {
      setState(() => isLoading = true);

      final groupId = widget.uri.queryParameters['group'];

      if (groupId != null) {
        final group = await controller.getGroupById(id: groupId);

        setState(() {
          groupModel = group;
        });
      } else {
        Modular.to.pushReplacementNamed(AppRoutes.home);
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

  void joinGroup() async {
    try {
      await controller.joinGroup(id: groupModel!.id);

      Modular.to.pushNamed(AppRoutes.home);
    } on FirebaseServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    loadGroupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: isLoading
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
                      groupModel?.name ?? 'Nome do Grupo',
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
                          "Data: ${groupModel?.eventDate}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Hora: ${groupModel?.eventTime}",
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
                          "Rua: ${groupModel?.address}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Nº: ${groupModel?.number}",
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
                      "Bairro: ${groupModel?.neighborhood}",
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Cidade: ${groupModel?.city}",
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
                          "CEP: ${groupModel?.zipCode}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "Valor: ${groupModel?.value}",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Modular.to.pushReplacementNamed(AppRoutes.home),
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
                          onPressed: joinGroup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
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
