import 'package:mtracker/app/services/database_service.dart';

import '../models/category_model.dart';

class CategoryProvider {
  static Future createCategory(CategoryModel category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.insert(
      CategoryModel.TABLE_NAME,
      category.toJson(),
    );
  }

  static CategoryModel defaultCategory() {
    return CategoryModel(id: "C20240903104201", name: "General", emoji: "📦");
  }

  static Future<CategoryModel> readCategoryById(String id) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      CategoryModel.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data.isNotEmpty) {
      return CategoryModel.fromJson(data.first);
    }
    return defaultCategory();
  }

  static Future<List<CategoryModel>> readAllCategory() async {
    var db = await DatabaseService().database;
    var data = await db.query(CategoryModel.TABLE_NAME);
    return data.map((e) {
      return CategoryModel.fromJson(e);
    }).toList();
  }

  static Future updateCategory(CategoryModel category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.update(
      CategoryModel.TABLE_NAME,
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future deleteCategory(CategoryModel category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      CategoryModel.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
