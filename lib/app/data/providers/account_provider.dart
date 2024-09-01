import 'package:mtracker/app/services/database_service.dart';

import '../models/account_model.dart';

class AccountProvider {
  static Future<List<Account>> getAllAccount() async {
    var db = await DatabaseService().database;
    var data = await db.query(Account.tableName);
    return data.map(
      (e) {
        return Account.fromJson(e);
      },
    ).toList();
  }
}
