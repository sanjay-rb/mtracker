import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/data/providers/transaction_record_provider.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';

class RecordController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  TextEditingController amountController = TextEditingController();
  Rx<String> dateTime = "".obs;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Rx<CategoryModel> category = CategoryProvider.defaultCategory().obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      TransactionRecordModel record = Get.arguments as TransactionRecordModel;

      amountController.text = record.amount.toString();
      noteController.text = record.note!;
      dateTime.value = record.dateTime!;

      updateCategory(
        await CategoryProvider.readCategoryById(record.category!),
      );
    } else {
      dateTime.value = DateConstant.dateTimeToDateString(DateTime.now());
      updateCategory(CategoryProvider.defaultCategory());
    }
    super.onInit();
  }

  void updateCategory(CategoryModel selected) {
    category.value = selected;
  }

  bool validateForm() {
    showSnack(String text) {
      Get.snackbar(
        "Warning",
        text,
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.error),
      );
    }

    if (amountController.text.isEmpty) {
      showSnack("Please enter a valid amount.");
      return false;
    }
    if (!amountController.text.isNum) {
      showSnack(
          "Please enter a valid number for the balance, avoiding any letters or symbols.");
      return false;
    }
    if (noteController.text.isEmpty) {
      showSnack("Please enter a valid note.");
      return false;
    }
    return true;
  }

  void updateDateTime(DateTime value) {
    dateTime.value = DateConstant.dateTimeToDateString(value);
  }

  Future<void> saveRecord(TransactionRecordModel? record) async {
    if (validateForm()) {
      TransactionRecordModel newObj = TransactionRecordModel(
        amount: double.parse(amountController.text),
        category: category.value.id,
        note: noteController.text,
        dateTime: dateTime.value,
      );

      debugPrint(newObj.toJson().toString());

      if (record != null) {
        newObj.id = record.id;
        await TransactionRecordProvider.updateRecord(newObj);
      } else {
        newObj.id = "R${DateConstant.generateID()}";
        await TransactionRecordProvider.createRecord(newObj);
      }
      Get.back(closeOverlays: true);
    }
  }

  Future<void> deleteRecord(TransactionRecordModel? record) async {
    await TransactionRecordProvider.deleteRecord(record!);
    Get.back();
  }
}
