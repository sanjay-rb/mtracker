import 'package:mtracker/app/constants/type_constant.dart';
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

  static Future<List<Category>> readAllCategory() async {
    List<Category> debit = await readCategoryByType(TypeConstant.debit);
    List<Category> credit = await readCategoryByType(TypeConstant.credit);
    List<Category> transfer = await readCategoryByType(TypeConstant.transfer);

    return debit + transfer + credit;
  }

  static Future<List<Category>> readCategoryByType(String type) async {
    var db = await DatabaseService().database;
    var data = await db.query(
      Category.tableName,
      where: 'default_record_type = ?',
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
