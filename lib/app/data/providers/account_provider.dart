import 'package:mtracker/app/services/database_service.dart';

import '../models/account_model.dart';

class AccountProvider {
  static Future createAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      Account.tableName,
      account.toJson(),
    );
  }

  static Future<List<Account>> readAllAccount() async {
    var db = await DatabaseService().database;
    var data = await db.query(Account.tableName, orderBy: 'id');
    return data.map((e) {
      return Account.fromJson(e);
    }).toList();
  }

  static Future updateAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      Account.tableName,
      account.toJson(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  static Future deleteAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      Account.tableName,
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }
}
