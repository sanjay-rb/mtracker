import 'package:mtracker/app/services/database_service.dart';

import '../models/transaction_record_model.dart';

class TransactionRecordProvider {
  static Future createRecord(TransactionRecord record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      TransactionRecord.TABLE_NAME,
      record.toJson(),
    );
  }

  static Future<List<TransactionRecord>> readCurrentMonthRecord() async {
    DateTime dateTime = DateTime.now();
    String currentMonth =
        "${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(4, '0')}";
    var db = await DatabaseService().database;

    var data = await db.query(
      TransactionRecord.TABLE_NAME,
      where: 'date_time LIKE ?',
      whereArgs: ['%$currentMonth%'],
    );
    return data.map((e) {
      return TransactionRecord.fromJson(e);
    }).toList();
  }

  static Future updateRecord(TransactionRecord record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      TransactionRecord.TABLE_NAME,
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  static Future<void> deleteRecord(TransactionRecord record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      TransactionRecord.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }
}
