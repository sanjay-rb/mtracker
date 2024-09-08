import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/widgets/from_to_widget.dart';
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
              Row(
                children: TypeConstant.valuesWithTransfer
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "From",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "To",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const FromToWidget(),
              const SizedBox(height: 10),
              Obx(
                () => Column(
                  children: [
                    if (controller.type.value == TypeConstant.debit)
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
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
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
                  ],
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
                          controller.dateTime.value),
                    ).then(
                      (date) {
                        if (date != null) {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              DateConstant.dateStringToDateTime(
                                  controller.dateTime.value),
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
