import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Mask {
  static String weight(String s) =>
      NumberFormat.decimalPattern('pt_BR').format(int.parse(s));

  static MaskTextInputFormatter get cellPhoneMask =>
      MaskTextInputFormatter(mask: '(##) # ####-####');
  static MaskTextInputFormatter get phoneMask =>
      MaskTextInputFormatter(mask: '(##) ####-####');
  static MaskTextInputFormatter get cnpjMask =>
      MaskTextInputFormatter(mask: '##.###.###/####-##');
  static MaskTextInputFormatter get cepMask =>
      MaskTextInputFormatter(mask: '#####-###');
  static MaskTextInputFormatter get cpfMask =>
      MaskTextInputFormatter(mask: '###.###.###-##');
  static MaskTextInputFormatter get dateMask =>
      MaskTextInputFormatter(mask: '##/##/####');
  static MaskTextInputFormatter get timeMask =>
      MaskTextInputFormatter(mask: '##:##');

  static CurrencyInputFormatter get moneyMask => CurrencyInputFormatter();

  static final numbersOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(
      newValue.text
          .replaceAll("R\$", "")
          .replaceAll(",", "")
          .replaceAll(".", ""),
    );

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
