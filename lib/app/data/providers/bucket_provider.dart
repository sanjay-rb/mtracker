import 'package:mtracker/app/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class BucketProvider {
  static const String TABLE_NAME = "bucket";
  DatabaseService service = DatabaseService();

  Future<List> getAllBucket() async {
    Database database = await service.database;
    var data = await database.query(TABLE_NAME);
    return data;
  }
}
