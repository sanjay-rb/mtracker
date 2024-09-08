import 'package:mtracker/app/constants/type_constant.dart';
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

  static Future<Category?> readCategoryById(String id) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Category.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data.isNotEmpty) {
      return Category.fromJson(data.first);
    }
    return null;
  }

  static Future<List<Category>> readAllCategory() async {
    List<Category> debit = await readCategoryByType(TypeConstant.debit);
    List<Category> credit = await readCategoryByType(TypeConstant.credit);

    return debit + credit;
  }

  static Future<List<Category>> readCategoryByType(String type) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Category.TABLE_NAME,
      where: 'type = ?',
      whereArgs: [type],
    );
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
