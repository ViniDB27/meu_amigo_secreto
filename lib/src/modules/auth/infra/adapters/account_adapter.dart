import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';

class AccountAdapter {
  AccountAdapter._();

  static AccountEntity fromJson(Map json) => AccountEntity(
        id: json['id'],
        name: json['name'],
        token: json['token'],
      );
}
