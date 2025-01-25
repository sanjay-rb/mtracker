import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/data/providers/transaction_record_provider.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';

class RecordController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  TextEditingController amountController = TextEditingController();
  Rx<String> type = TypeConstant.debit.obs;
  Rx<String> rule = RuleConstant.nr.obs;
  Rx<String> dateTime = "".obs;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Rx<Category> category = Category().obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      TransactionRecord record = Get.arguments as TransactionRecord;

      amountController.text = record.amount.toString();
      noteController.text = record.note!;
      dateTime.value = record.dateTime!;

      updateType(record.type!);
      updateCategory(
        (await CategoryProvider.readCategoryById(record.category!))!,
      );
    } else {
      dateTime.value = DateConstant.dateTimeToDateString(DateTime.now());
      updateCategory((await CategoryProvider.readAllCategory()).first);
    }
    super.onInit();
  }

  void updateCategory(Category selected) {
    category.value = selected;
    if (selected.id != null) {
      updateRule(selected.rule!);
    } else {
      updateRule(RuleConstant.nr);
    }
  }

  Future<void> updateType(String element) async {
    type.value = element;
    if (element == TypeConstant.transfer) {
      updateCategory(
        Category(
          id: "DEFAULT_TRANSFER_CATEGORY",
          emoji: "🔃",
          name: "Transfer",
          rule: RuleConstant.nr,
          type: element,
        ),
      );
    } else {
      updateCategory(Category());
    }
  }

  void updateRule(String element) {
    rule.value = element;
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

  Future<void> saveRecord(TransactionRecord? record) async {
    if (validateForm()) {
      TransactionRecord newObj = TransactionRecord(
        sourceAccount: "NR",
        targetAccount: "NR",
        amount: double.parse(amountController.text),
        category: category.value.id ?? "DEFAULT_TRANSFER_CATEGORY",
        note: noteController.text,
        rule: rule.value,
        type: type.value,
        dateTime: DateConstant.dateTimeToDateString(DateTime.now()),
      );

      if (record != null) {
        newObj.id = record.id;
        await TransactionRecordProvider.updateRecord(newObj);
      } else {
        newObj.id = "R${DateConstant.generateID()}";
        await TransactionRecordProvider.createRecord(newObj);
        if (newObj.type == TypeConstant.debit) {}
      }

      Get.back(closeOverlays: true);
    }
  }

  Future<void> deleteRecord(TransactionRecord? record) async {
    await TransactionRecordProvider.deleteRecord(record!);
    Get.back();
  }
}
