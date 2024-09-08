import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';
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
  Rx<Account> srcAccount = Account().obs;
  Rx<Account> tgtAccount = Account().obs;

  Rx<Category> category = Category().obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      TransactionRecord record = Get.arguments as TransactionRecord;

      amountController.text = record.amount.toString();
      noteController.text = record.note!;
      dateTime.value = record.dateTime!;

      updateType(record.type!);
      updateSrcAccount(
        (await AccountProvider.readAccountById(record.sourceAccount!))!,
      );
      updateTgtAccount(
        (await AccountProvider.readAccountById(record.targetAccount!))!,
      );
      updateCategory(
        (await CategoryProvider.readCategoryById(record.category!))!,
      );
    } else {
      dateTime.value = DateConstant.dateTimeToDateString(DateTime.now());
      updateSrcAccount((await AccountProvider.readAllAccount()).first);
      updateTgtAccount((await AccountProvider.readAllAccount()).first);
      updateCategory((await CategoryProvider.readAllCategory()).first);
    }
    super.onInit();
  }

  void updateSrcAccount(Account selected) {
    srcAccount.value = selected;
  }

  void updateTgtAccount(Account selected) {
    tgtAccount.value = selected;
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
    updateSrcAccount(Account());
    updateTgtAccount(Account());
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

    if (type.value == TypeConstant.debit) {
      if (srcAccount.value.id == null) {
        showSnack("Please choose a valid source account");
        return false;
      }
      if (category.value.id == null) {
        showSnack("Please choose a valid category");
        return false;
      }
    }

    if (type.value == TypeConstant.credit) {
      if (category.value.id == null) {
        showSnack("Please choose a valid category");
        return false;
      }
      if (tgtAccount.value.id == null) {
        showSnack("Please choose a valid target account");
        return false;
      }
    }
    if (type.value == TypeConstant.transfer) {
      if (srcAccount.value.id == null) {
        showSnack("Please choose a valid source account");
        return false;
      }
      if (tgtAccount.value.id == null) {
        showSnack("Please choose a valid target account");
        return false;
      }
    }
    return true;
  }

  void updateDateTime(DateTime value) {
    dateTime.value = DateConstant.dateTimeToDateString(value);
  }

  Future<void> saveRecord(TransactionRecord? record) async {
    if (validateForm()) {
      TransactionRecord newObj = TransactionRecord(
        sourceAccount: srcAccount.value.id ?? "NR",
        targetAccount: tgtAccount.value.id ?? "NR",
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
        if (newObj.type == TypeConstant.debit) {
          Account? account =
              await AccountProvider.readAccountById(newObj.sourceAccount!);
          if (account != null) {
            account.balance = account.balance! - newObj.amount!;
            AccountProvider.updateAccount(account);
          }
        }
      }

      // if (newObj.type == TypeConstant.credit) {
      //   BudgetBucket? bucket =
      //       await BudgetBucketProvider.readBucketByYearMonth();
      //   BudgetBucket newBucketObj = BudgetBucket();
      //   if (bucket == null) {
      //     newBucketObj = BudgetBucket(
      //       id: DateConstant.generateID(),
      //       totalCredit: newObj.amount,
      //       needs: (newObj.amount! * .5),
      //       wants: (newObj.amount! * .3),
      //       saves: (newObj.amount! * .2),
      //       totalDebit: 0,
      //       yearMonth: DateFormat.yM().format(DateTime.now()),
      //     );
      //     await BudgetBucketProvider.createBucket(newBucketObj);
      //   } else {
      //     double totalAmt = newObj.amount! + bucket.totalCredit!;
      //     newBucketObj = BudgetBucket(
      //       id: bucket.id,
      //       totalCredit: totalAmt,
      //       needs: (totalAmt * .5),
      //       wants: (totalAmt * .3),
      //       saves: (totalAmt * .2),
      //       totalDebit: 0,
      //       yearMonth: bucket.yearMonth,
      //     );
      //     await BudgetBucketProvider.updateBucket(newBucketObj);
      //   }
      // }
      Get.back(closeOverlays: true);
    }
  }

  Future<void> deleteRecord(TransactionRecord? record) async {
    await TransactionRecordProvider.deleteRecord(record!);
    Get.back();
  }
}
