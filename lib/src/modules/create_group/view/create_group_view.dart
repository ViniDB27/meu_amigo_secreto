import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/utils/mask.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/create_group_controller.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-4588189843597373/1122231207',
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void initState() {
    myBanner.load();
    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CreateGroupController>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SizedBox(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 60,
              width: mediaQuery.size.width,
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Center(
                child: AdWidget(
                  ad: myBanner,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formStateKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Criar Novo Grupo',
                          style: GoogleFonts.itim().copyWith(
                            fontSize: 40,
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
                        const SizedBox(height: 40),
                        TextFieldCustom(
                          label: 'Nome do Grupo',
                          controller: controller.nameController,
                          fieldValidator: (value) =>
                              controller.fieldIsNotEmptyValidator(value ?? ''),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'Data do Sorteio',
                                keyboardType: TextInputType.number,
                                controller: controller.drawDateController,
                                inputFormatters: [Mask.dateMask],
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'Valor Sugerido',
                                keyboardType: TextInputType.number,
                                inputFormatters: [Mask.moneyMask],
                                controller: controller.valueController,
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Dados do Evento',
                          style: GoogleFonts.itim().copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'Data',
                                keyboardType: TextInputType.number,
                                controller: controller.eventDateController,
                                inputFormatters: [Mask.dateMask],
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'Hora',
                                keyboardType: TextInputType.number,
                                controller: controller.eventTimeController,
                                inputFormatters: [Mask.timeMask],
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustom(
                          label: 'Rua',
                          controller: controller.addressController,
                          fieldValidator: (value) =>
                              controller.fieldIsNotEmptyValidator(value ?? ''),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'Bairro',
                                controller: controller.neighborhoodController,
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                            SizedBox(
                              width: (mediaQuery.size.width - 60) / 2,
                              child: TextFieldCustom(
                                label: 'N°',
                                keyboardType: TextInputType.number,
                                controller: controller.numberController,
                                fieldValidator: (value) => controller
                                    .fieldIsNotEmptyValidator(value ?? ''),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustom(
                          label: 'Cidade',
                          controller: controller.cityController,
                          fieldValidator: (value) =>
                              controller.fieldIsNotEmptyValidator(value ?? ''),
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustom(
                          label: 'CEP',
                          controller: controller.zipCodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [Mask.cepMask],
                          fieldValidator: (value) =>
                              controller.fieldIsNotEmptyValidator(value ?? ''),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => controller.createNewGroup(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            padding: EdgeInsets.symmetric(
                              horizontal: (mediaQuery.size.width / 2) - 100,
                              vertical: 10,
                            ),
                          ),
                          child: controller.loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Criar Grupo',
                                  style: AppFonts.interNormal(context),
                                ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
