import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
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
  final formStateKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final drawDateController = TextEditingController();
  final valueController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();
  final addressController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final numberController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();

  final controller = Modular.get<CreateGroupController>();

  bool isLoading = false;

  void onSubmitButtonPressed() async {
    setState(() => isLoading = true);

    try {
      if (formStateKey.currentState?.validate() == true) {
        await controller.createNewGroup(
          name: nameController.text,
          drawDate: drawDateController.text,
          value: valueController.text,
          eventDate: eventDateController.text,
          eventTime: eventTimeController.text,
          address: addressController.text,
          neighborhood: neighborhoodController.text,
          number: numberController.text,
          city: cityController.text,
          zipCode: zipCodeController.text,
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Grupo Criado com Sucesso!"),
        ));

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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: SingleChildScrollView(
          child: Form(
            key: formStateKey,
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
                  controller: nameController,
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
                        controller: drawDateController,
                        inputFormatters: [Mask.dateMask],
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: (mediaQuery.size.width - 60) / 2,
                      child: TextFieldCustom(
                        label: 'Valor Sujerido',
                        keyboardType: TextInputType.number,
                        inputFormatters: [Mask.moneyMask],
                        controller: valueController,
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
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
                        controller: eventDateController,
                        inputFormatters: [Mask.dateMask],
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: (mediaQuery.size.width - 60) / 2,
                      child: TextFieldCustom(
                        label: 'Hora',
                        keyboardType: TextInputType.number,
                        controller: eventTimeController,
                        inputFormatters: [Mask.timeMask],
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  label: 'Rua',
                  controller: addressController,
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
                        controller: neighborhoodController,
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: (mediaQuery.size.width - 60) / 2,
                      child: TextFieldCustom(
                        label: 'N°',
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  label: 'Cidade',
                  controller: cityController,
                  fieldValidator: (value) =>
                      controller.fieldIsNotEmptyValidator(value ?? ''),
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  label: 'CEP',
                  controller: zipCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [Mask.cepMask],
                  fieldValidator: (value) =>
                      controller.fieldIsNotEmptyValidator(value ?? ''),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onSubmitButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    padding: EdgeInsets.symmetric(
                      horizontal: (mediaQuery.size.width / 2) - 100,
                      vertical: 10,
                    ),
                  ),
                  child: isLoading
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
    );
  }
}
