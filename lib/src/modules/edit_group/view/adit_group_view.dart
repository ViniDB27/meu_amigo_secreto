import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/theme/app_fonts.dart';
import '../../../core/shared/theme/app_images.dart';
import '../../../core/shared/utils/alert_dialog.dart';
import '../../../core/shared/utils/mask.dart';
import '../../../core/shared/widgets/text_field_custom_widget.dart';
import '../controller/edit_group_controller.dart';

class EditGroupView extends StatefulWidget {
  const EditGroupView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<EditGroupView> createState() => _EditGroupViewState();
}

class _EditGroupViewState extends State<EditGroupView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EditGroupController>(context, listen: false).getGroupById(
        context,
        widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EditGroupController>(context);
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
            key: controller.formStateKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Editar Grupo',
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
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: (mediaQuery.size.width - 60) / 2,
                      child: TextFieldCustom(
                        label: 'Valor Sugerido',
                        keyboardType: TextInputType.number,
                        inputFormatters: [Mask.moneyMask],
                        controller: controller.valueController,
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
                        controller: controller.eventDateController,
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
                        controller: controller.eventTimeController,
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
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: (mediaQuery.size.width - 60) / 2,
                      child: TextFieldCustom(
                        label: 'N°',
                        keyboardType: TextInputType.number,
                        controller: controller.numberController,
                        fieldValidator: (value) =>
                            controller.fieldIsNotEmptyValidator(value ?? ''),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () => alertDialog(
                            context: context,
                            title: 'Excluir Grupo',
                            content: 'Deseja realmente excluir o grupo?',
                            onPressedConfirm: () =>
                                controller.deleteGroup(context),
                            onPressedCancel: () =>
                                Navigator.pop(context, 'Cancelar'),
                          ),
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.editGroup(context),
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
                              'Editar Grupo',
                              style: AppFonts.interNormal(context),
                            ),
                    ),
                    const SizedBox(width: 5),
                  ],
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
