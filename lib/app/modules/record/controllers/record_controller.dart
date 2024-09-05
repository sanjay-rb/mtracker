import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';

class RecordController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  RxList<Category> categoryList = <Category>[].obs;

  TextEditingController amountController = TextEditingController();
  Rx<String> type = TypeConstant.credit.obs;
  Rx<String> rule = RuleConstant.needs.obs;
  Rx<String> dateTime = "".obs;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  Rx<Account?> account = Account(
    id: 'na',
    name: "NAME",
    balance: 0.0,
    emoji: '🏦',
  ).obs;

  Rx<Category?> category = Category(
    id: 'na',
    emoji: '😃',
    name: 'NAME',
    defaultRecordType: TypeConstant.debit,
    defaultRuleBucket: RuleConstant.na,
  ).obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      TransactionRecord record = Get.arguments as TransactionRecord;

      amountController.text = record.amount.toString();
      noteController.text = record.note!;
      dateTime.value = record.dateTime!;

      updateAccount(
        homeController.accounts.where((p0) => p0.id == record.account).first,
      );
      updateCategory(
        homeController.categories.where((p0) => p0.id == record.category).first,
      );
      updateRule(record.rule!);
      updateType(record.type!);
    } else {
      dateTime.value = DateConstant.dateTimeToDateString(DateTime.now());
      updateAccount(homeController.accounts.first);
      updateCategory(homeController.categories.first);
    }
    super.onInit();
  }

  void updateAccount(Account selected) {
    account.value = selected;
  }

  void updateCategory(Category selected) {
    category.value = selected;
    updateType(selected.defaultRecordType!);
    updateRule(selected.defaultRuleBucket!);
  }

  void updateType(String element) {
    type.value = element;
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
}
