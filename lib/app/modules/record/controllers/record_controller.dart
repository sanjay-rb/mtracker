import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';

class RecordController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  TextEditingController amountController = TextEditingController();
  Rx<String> type = TypeConstant.credit.obs;
  Rx<String> rule = RuleConstant.needs.obs;
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
      type.value = record.type!;
      rule.value = record.rule!;
      dateTimeController.text = record.dateTime!;
      noteController.text = record.note!;
      account.value =
          homeController.accounts.where((p0) => p0.id == record.account).first;
      category.value = homeController.categories
          .where((p0) => p0.id == record.category)
          .first;
    }
    super.onInit();
  }
}
