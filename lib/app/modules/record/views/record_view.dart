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
import 'package:mtracker/app/widgets/text_input_field_widget.dart';

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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Divider(),
              TextInputFieldWidget(
                textEditingController: controller.amountController,
                hint: record == null ? '0.0' : record!.amount.toString(),
                type: TextInputType.number,
                align: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Account",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Category",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      child: ElevatedButton.icon(
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
                        label: Obx(
                          () => Text(
                            controller.account.value!.name.toString(),
                          ),
                        ),
                        icon: Obx(
                          () => Text(
                            controller.account.value!.emoji.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
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
                        label: Obx(
                          () => Text(
                            controller.category.value!.name.toString(),
                          ),
                        ),
                        icon: Obx(
                          () => Text(
                            controller.category.value!.emoji.toString(),
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
                            () => ElevatedButton(
                              onPressed: () {
                                controller.updateType(element);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  controller.type.value == element
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: Text(element),
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
                            () => ElevatedButton(
                              onPressed: () {
                                controller.updateRule(element);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  controller.rule.value == element
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: Text(element),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              TextInputFieldWidget(
                textEditingController: controller.noteController,
                hint: record == null ? 'Note' : record!.note.toString(),
                type: TextInputType.text,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      initialDate: DateTime.now(),
                    ).then(
                      (date) {
                        if (date != null) {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then(
                            (time) {
                              if (time != null) {
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
                          );
                        }
                      },
                    );
                  },
                  label: Obx(
                    () => Text(controller.dateTime.value),
                  ),
                  icon: const Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (record != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text("DELETE"),
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await TransactionRecordProvider.deleteRecord(
                                  record!);
                              Get.back();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.red.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text("SAVE"),
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
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.green.shade800,
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
