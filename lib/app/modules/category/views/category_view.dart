import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';

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
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: controller.emojiController,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText:
                              category == null ? 'Emoji' : category!.emoji,
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
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.nameController,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: category == null ? 'Name' : category!.name,
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
                        textAlign: TextAlign.start,
                      ),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  if (category != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await CategoryProvider.deleteCategory(category!);
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
                            Category newCategoryObj = Category(
                              name: controller.nameController.text,
                              emoji: controller.emojiController.text,
                              defaultRecordType: controller.type.value,
                              defaultRuleBucket: controller.rule.value,
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
