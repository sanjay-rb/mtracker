import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/services/database_service.dart';

class CategoryController extends GetxController {
  TextEditingController emojiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Rx<String> type = TypeConstant.credit.obs;
  Rx<String> rule = RuleConstant.needs.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      Category category = Get.arguments as Category;
      type.value = category.defaultRecordType!;
      rule.value = category.defaultRuleBucket!;
    }
    super.onInit();
  }

  void updateType(String element) {
    type.value = element;
  }

  void updateRule(String element) {
    rule.value = element;
  }

  Future<void> deleteCategory(Category? category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    await db.delete(
      Category.tableName,
      where: 'name = ?',
      whereArgs: [category!.name],
    );
    Get.back();
  }

  Future<void> saveCategory(Category? category) async {
    DatabaseService databaseService = DatabaseService();
    var db = await databaseService.database;
    List<Map<String, Object?>> data = await db.query(Category.tableName,
        where: 'name = ?', whereArgs: [category!.name]);

    print(data);
  }
}
