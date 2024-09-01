import 'package:mtracker/app/services/database_service.dart';

import '../models/category_model.dart';

class CategoryProvider {
  static Future<List<Category>> getAllACategory() async {
    var db = await DatabaseService().database;
    var data =
        await db.query(Category.tableName, orderBy: "default_record_type");
    return data.map(
      (e) {
        return Category.fromJson(e);
      },
    ).toList();
  }
}
