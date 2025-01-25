import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/widgets/text_input_field_widget.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  final Category? category;
  const CategoryView(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                category == null
                    ? "➕ ADD CATEGORY"
                    : "${category!.emoji} ${category!.name!.toUpperCase()}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextInputFieldWidget(
                      textEditingController: controller.emojiController,
                      hint: category == null ? 'Emoji' : category!.emoji!,
                      type: TextInputType.text,
                      align: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: TextInputFieldWidget(
                      textEditingController: controller.nameController,
                      hint: category == null ? 'Name' : category!.name!,
                      type: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                              child: Text(
                                element,
                                style: TextStyle(
                                  color: controller.type.value == element
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
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
                                      child: Text(
                                        element,
                                        style: TextStyle(
                                          color:
                                              controller.rule.value == element
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary,
                                        ),
                                      ),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  if (category != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text("DELETE"),
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await CategoryProvider.deleteCategory(category!);
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
                            Category newCategoryObj = Category(
                              name: controller.nameController.text,
                              emoji: controller.emojiController.text,
                            );
                            if (category != null) {
                              newCategoryObj.id = category!.id;
                              await CategoryProvider.updateCategory(
                                newCategoryObj,
                              );
                            } else {
                              newCategoryObj.id = DateConstant.generateID();
                              await CategoryProvider.createCategory(
                                newCategoryObj,
                              );
                            }
                            Get.back();
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
