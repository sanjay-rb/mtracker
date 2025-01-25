import 'package:mtracker/app/services/database_service.dart';

import '../models/category_model.dart';

class CategoryProvider {
  static Future createCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      Category.TABLE_NAME,
      category.toJson(),
    );
  }

  static Category defaultCategory() {
    return Category(id: "C20240903104201", name: "General", emoji: "📦");
  }

  static Future<Category> readCategoryById(String id) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Category.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data.isNotEmpty) {
      return Category.fromJson(data.first);
    }
    return defaultCategory();
  }

  static Future<List<Category>> readAllCategory() async {
    var db = await DatabaseService().database;
    var data = await db.query(Category.TABLE_NAME);
    return data.map((e) {
      return Category.fromJson(e);
    }).toList();
  }

  static Future updateCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      Category.TABLE_NAME,
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future deleteCategory(Category category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      Category.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
