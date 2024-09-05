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
import 'package:mtracker/app/widgets/bottom_sheet_widget.dart';

import '../controllers/record_controller.dart';

class RecordView extends GetView<RecordController> {
  final TransactionRecord? record;
  const RecordView(this.record, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                "💸 RECORD",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  controller: controller.amountController,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText:
                        record == null ? '0.0' : record!.amount.toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Account",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Category",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          AccountProvider.readAllAccount().then((accountList) {
                            showModalBottomSheet<Account>(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetWidget(
                                  title: "Accounts",
                                  listData: controller.homeController.accounts,
                                );
                              },
                            ).then((selected) async {
                              if (selected != null) {
                                controller.updateAccount(selected);
                              }
                            });
                          });
                        },
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FittedBox(
                            child: Obx(
                              () => Text(
                                '${controller.account.value!.emoji!} ${controller.account.value!.name!}',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          CategoryProvider.readAllACategory()
                              .then((accountList) {
                            showModalBottomSheet<Category>(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetWidget(
                                  title: "Categories",
                                  listData:
                                      controller.homeController.categories,
                                );
                              },
                            ).then((selected) async {
                              if (selected != null) {
                                controller.updateCategory(selected);
                              }
                            });
                          });
                        },
                        color: Theme.of(context).colorScheme.tertiary,
                        child: FittedBox(
                          child: Obx(
                            () => Text(
                              '${controller.category.value!.emoji!} ${controller.category.value!.name!}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: TypeConstant.values
                    .map(
                      (String element) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Obx(
                            () => MaterialButton(
                              onPressed: () {
                                controller.updateType(element);
                              },
                              color: controller.type.value == element
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FittedBox(
                                  child: Text(
                                    element,
                                    style: TextStyle(
                                      color: controller.type.value == element
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Row(
                children: RuleConstant.values
                    .map(
                      (String element) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Obx(
                            () => MaterialButton(
                              onPressed: () {
                                controller.updateRule(element);
                              },
                              color: controller.rule.value == element
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FittedBox(
                                  child: Text(
                                    element,
                                    style: TextStyle(
                                      color: controller.rule.value == element
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  controller: controller.noteController,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: record == null ? 'Note' : record!.note,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Theme.of(context).colorScheme.secondary,
                            onPrimary: Theme.of(context).colorScheme.primary,
                            onSurface: Theme.of(context).colorScheme.tertiary,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.tertiary),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Theme.of(context).colorScheme.secondary,
                            onPrimary: Theme.of(context).colorScheme.primary,
                            onSurface: Theme.of(context).colorScheme.tertiary,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.tertiary),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (date != null && time != null) {
                      DateTime dateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      controller.updateDateTime(dateTime);
                    }
                  },
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Obx(
                      () => FittedBox(
                        child: Text(
                          controller.dateTime.value,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (record != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await TransactionRecordProvider.deleteRecord(
                                  record!);
                              Get.back();
                            }
                          },
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: FittedBox(
                              child: Text("DELETE"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () async {
                          if (controller.validateForm()) {
                            TransactionRecord newObj = TransactionRecord(
                              account: controller.account.value!.id!,
                              amount: double.parse(
                                controller.amountController.text,
                              ),
                              category: controller.category.value!.id,
                              note: controller.noteController.text,
                              rule: controller.rule.value,
                              type: controller.type.value,
                              dateTime: DateConstant.dateTimeToDateString(
                                DateTime.now(),
                              ),
                            );
                            if (record != null) {
                              newObj.id = record!.id;
                              await TransactionRecordProvider.updateRecord(
                                newObj,
                              );
                            } else {
                              newObj.id = DateConstant.generateID();
                              await TransactionRecordProvider.createRecord(
                                newObj,
                              );
                            }
                            Get.back(closeOverlays: true);
                          }
                        },
                        color: Colors.green,
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: FittedBox(
                            child: Text("SAVE"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
