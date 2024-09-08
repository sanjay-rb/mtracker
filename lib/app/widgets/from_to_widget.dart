import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/modules/record/controllers/record_controller.dart';
import 'package:mtracker/app/widgets/bottom_sheet_widget.dart';

class FromToWidget extends GetWidget<RecordController> {
  const FromToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.type.value == TypeConstant.debit)
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
                                listData: accountList,
                              );
                            },
                          ).then((selected) async {
                            if (selected != null) {
                              controller.updateSrcAccount(selected);
                            }
                          });
                        });
                      },
                      label: Obx(
                        () => Text(
                          controller.srcAccount.value.name ?? "Source Account",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.srcAccount.value.emoji ?? "🏦",
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
                        CategoryProvider.readCategoryByType(
                                controller.type.value)
                            .then((categories) {
                          showModalBottomSheet<Category>(
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
                        () => Text(
                          controller.category.value.name ?? "Category",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.category.value.emoji ?? "📦",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (controller.type.value == TypeConstant.credit)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        CategoryProvider.readCategoryByType(
                                controller.type.value)
                            .then((categories) {
                          showModalBottomSheet<Category>(
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
                        () => Text(
                          controller.category.value.name ?? "Category",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.category.value.emoji ?? "📦",
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
                              controller.updateTgtAccount(selected);
                            }
                          });
                        });
                      },
                      label: Obx(
                        () => Text(
                          controller.tgtAccount.value.name ?? "Target Account",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.tgtAccount.value.emoji ?? "🏦",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (controller.type.value == TypeConstant.transfer)
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
                                listData: accountList,
                              );
                            },
                          ).then((selected) async {
                            if (selected != null) {
                              controller.updateSrcAccount(selected);
                            }
                          });
                        });
                      },
                      label: Obx(
                        () => Text(
                          controller.srcAccount.value.name ?? "Source Account",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.srcAccount.value.emoji ?? "🏦",
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
                              controller.updateTgtAccount(selected);
                            }
                          });
                        });
                      },
                      label: Obx(
                        () => Text(
                          controller.tgtAccount.value.name ?? "Target Account",
                        ),
                      ),
                      icon: Obx(
                        () => Text(
                          controller.tgtAccount.value.emoji ?? "🏦",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
