import 'package:mtracker/app/services/database_service.dart';

import '../models/category_model.dart';

class CategoryProvider {
  // CRUD
  static Future createCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      Category.tableName,
      category.toJson(),
    );
  }

  static Future<Category?> readCategoryById(String id) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Category.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data.isNotEmpty) {
      return Category.fromJson(data.first);
    }
    return null;
  }

  static Future<List<Category>> readAllACategory() async {
    var db = await DatabaseService().database;
    var data =
        await db.query(Category.tableName, orderBy: "default_record_type");
    return data.map((e) {
      return Category.fromJson(e);
    }).toList();
  }

  static Future updateCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      Category.tableName,
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future deleteCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      Category.tableName,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
