import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/widgets/bottom_sheet_widget.dart';
import 'package:mtracker/app/widgets/text_input_field_widget.dart';

import '../controllers/record_controller.dart';

class RecordView extends GetView<RecordController> {
  final TransactionRecordModel? record;
  const RecordView(this.record, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "💸 RECORD",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    TextInputFieldWidget(
                      textEditingController: controller.amountController,
                      hint: record == null ? '0.0' : record!.amount.toString(),
                      type: TextInputType.number,
                      align: TextAlign.center,
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
                          CategoryProvider.readAllCategory().then((categories) {
                            showModalBottomSheet<CategoryModel>(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetWidget(
                                  title: "Categories",
                                  listData: categories,
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
                          () => Text(controller.category.value.name!),
                        ),
                        icon: Obx(
                          () => Text(controller.category.value.emoji!),
                        ),
                      ),
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
                            initialDate: DateConstant.dateStringToDateTime(
                              controller.dateTime.value,
                            ),
                          ).then(
                            (date) {
                              if (date != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                    DateConstant.dateStringToDateTime(
                                      controller.dateTime.value,
                                    ),
                                  ),
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
                  ],
                ),
              ),
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
                            await controller.deleteRecord(record);
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
                          await controller.saveRecord(record);
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
