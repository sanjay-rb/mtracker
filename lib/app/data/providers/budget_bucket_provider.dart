import 'package:intl/intl.dart';
import 'package:mtracker/app/services/database_service.dart';

import '../models/budget_bucket_model.dart';

class BudgetBucketProvider {
  static Future createBucket(BudgetBucket bucket) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      BudgetBucket.TABLE_NAME,
      bucket.toJson(),
    );
  }

  static Future<BudgetBucket?> readBucketByYearMonth() async {
    String yearMonth = DateFormat.yM().format(DateTime.now());
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    var data = await db.query(
      BudgetBucket.TABLE_NAME,
      where: 'year_month = ?',
      whereArgs: [yearMonth],
    );
    if (data.isNotEmpty) {
      return BudgetBucket.fromJson(data.first);
    }
    return null;
  }

  static Future<List<BudgetBucket>> readAllBucket() async {
    var db = await DatabaseService().database;
    var data = await db.query(BudgetBucket.TABLE_NAME, orderBy: 'id');
    return data.map((e) {
      return BudgetBucket.fromJson(e);
    }).toList();
  }

  static Future updateBucket(BudgetBucket bucket) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      BudgetBucket.TABLE_NAME,
      bucket.toJson(),
      where: 'id = ?',
      whereArgs: [bucket.id],
    );
  }
}
