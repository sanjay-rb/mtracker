import 'package:mtracker/app/services/database_service.dart';

import '../models/transaction_record_model.dart';

class TransactionRecordProvider {
  static Future createRecord(TransactionRecord record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      TransactionRecord.tableName,
      record.toJson(),
    );
  }

  static Future<List<TransactionRecord>> readCurrentMonthRecord() async {
    DateTime dateTime = DateTime.now();
    String currentMonth =
        "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}";
    var db = await DatabaseService().database;

    var data = await db.query(
      TransactionRecord.tableName,
      where: 'date_time LIKE ?',
      whereArgs: ['$currentMonth%'],
    );
    return data.map((e) {
      return TransactionRecord.fromJson(e);
    }).toList();
  }
}
