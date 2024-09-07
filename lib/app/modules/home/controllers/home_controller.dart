import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/budget_bucket_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';
import 'package:mtracker/app/data/providers/budget_bucket_provider.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/data/providers/transaction_record_provider.dart';

class HomeController extends GetxController {
  var bottomNavBarIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  var categories = <Category>[].obs;
  var records = <TransactionRecord>[].obs;
  var accounts = <Account>[].obs;

  Rx<BudgetBucket?> bucket = BudgetBucket(
    id: DateConstant.generateID(),
    yearMonth: DateFormat.yM().format(DateTime.now()),
    totalCredit: 0,
    needs: 0,
    saves: 0,
    wants: 0,
    na: 0,
    totalDebit: 0,
  ).obs;

  @override
  Future<void> onInit() async {
    updateCategories();
    updateAccounts();
    updateRecords();
    updateBuckets();
    super.onInit();
  }

  updateBottomNavBarIndex(value) {
    bottomNavBarIndex.value = value;
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
  }

  Future<void> updateCategories() async {
    categories.value = await CategoryProvider.readAllCategory();
  }

  Future<void> updateAccounts() async {
    accounts.value = await AccountProvider.readAllAccount();
  }

  Future<void> updateRecords() async {
    records.value = await TransactionRecordProvider.readCurrentMonthRecord();
  }

  Future<void> updateBuckets() async {
    BudgetBucket? value = await BudgetBucketProvider.readBucketByYearMonth();
    if (value != null) {
      bucket.value = value;
    }
  }
}
