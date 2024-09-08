import 'package:mtracker/app/services/database_service.dart';

import '../models/account_model.dart';

class AccountProvider {
  static Future createAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      Account.TABLE_NAME,
      account.toJson(),
    );
  }

  static Future<Account?> readAccountById(String id) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Account.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data.isNotEmpty) {
      return Account.fromJson(data.first);
    }
    return null;
  }

  static Future<List<Account>> readAllAccount() async {
    var db = await DatabaseService().database;
    var data = await db.query(Account.TABLE_NAME, orderBy: 'id');
    return data.map((e) {
      return Account.fromJson(e);
    }).toList();
  }

  static Future updateAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      Account.TABLE_NAME,
      account.toJson(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  static Future deleteAccount(Account account) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      Account.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }
}
