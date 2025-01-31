import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/services/database_service.dart';

import '../models/transaction_record_model.dart';

class TransactionRecordProvider {
  static Future createRecord(TransactionRecordModel record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      TransactionRecordModel.TABLE_NAME,
      record.toJson(),
    );
  }

  static Future<List<TransactionRecordModel>> readCurrentMonthRecord() async {
    DateTime dateTime = DateTime.now();
    String currentMonth =
        "${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(4, '0')}";
    var db = await DatabaseService().database;

    var data = await db.query(
      TransactionRecordModel.TABLE_NAME,
      where: 'date_time LIKE ?',
      whereArgs: ['%$currentMonth%'],
      orderBy: 'date_time DESC',
    );
    return data.map((e) {
      return TransactionRecordModel.fromJson(e);
    }).toList();
  }

  static Future<double> readTotalDebit() async {
    var db = await DatabaseService().database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) AS amount FROM ${TransactionRecordModel.TABLE_NAME}');
    double totalAmount = result.isNotEmpty && result[0]['amount'] != null
        ? result[0]['amount']
        : 0.0;
    return totalAmount;
  }

  static Future<double> readTotalDebitByCategory(CategoryModel category) async {
    var db = await DatabaseService().database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) AS amount FROM ${TransactionRecordModel.TABLE_NAME} WHERE category = "${category.id}"');
    double totalAmount = result.isNotEmpty && result[0]['amount'] != null
        ? result[0]['amount']
        : 0.0;
    return totalAmount;
  }

  static Future updateRecord(TransactionRecordModel record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      TransactionRecordModel.TABLE_NAME,
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  static Future<void> deleteRecord(TransactionRecordModel record) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      TransactionRecordModel.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }
}
