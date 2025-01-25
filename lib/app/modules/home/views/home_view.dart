import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/routes/app_pages.dart';
import 'package:mtracker/app/services/database_service.dart';
import 'package:mtracker/app/widgets/bucket_budget_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller.bottomNavBarIndex.value == 0) {
            await Get.toNamed(Routes.RECORD, arguments: null);
            controller.updateRecords();
          } else {
            await Get.toNamed(
              Routes.CATEGORY,
              arguments: null,
            );
            controller.updateCategories();
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.bottomNavBarIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Categories",
            ),
          ],
          onTap: (value) {
            controller.updateBottomNavBarIndex(value);
          },
          showUnselectedLabels: true,
          showSelectedLabels: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PageView(
            controller: controller.pageController,
            children: [
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat.yMMMM().format(DateTime.now()),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const Spacer(),
                          IconButton.filled(
                            onPressed: () async {
                              DatabaseService service = DatabaseService();
                              var db = await service.database;
                              await service.resetDatabase(db);
                              controller.updateCategories();
                              controller.updateRecords();
                            },
                            icon: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      const BucketBudgetWidget(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "History",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              debugPrint("Filter");
                            },
                            icon: const Icon(Icons.filter_alt),
                            label: const Text("Filter"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Column(
                          children: controller.records.isEmpty
                              ? [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Currently, no records available for this month.",
                                      ),
                                    ],
                                  ),
                                ]
                              : List.generate(
                                  controller.records.length,
                                  (index) {
                                    TransactionRecord record =
                                        controller.records[index];

                                    return RecordListTileWidget(
                                      record: record,
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CATEGORIES",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Click to edit the items"),
                          SizedBox(width: 5),
                          Icon(Icons.edit)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Obx(
                          () => Wrap(
                            runAlignment: WrapAlignment.center,
                            alignment: WrapAlignment.center,
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              controller.categories.length,
                              (index) {
                                Category category =
                                    controller.categories[index];
                                return InkWell(
                                  onTap: () async {
                                    debugPrint(category.name);
                                    await Get.toNamed(
                                      Routes.CATEGORY,
                                      arguments: category,
                                    );
                                    controller.updateCategories();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          category.emoji.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          category.name.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
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

class RecordListTileWidget extends GetWidget<HomeController> {
  const RecordListTileWidget({super.key, required this.record});

  final TransactionRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey),
        ),
      ),
      child: InkWell(
        onTap: () async {
          await Get.toNamed(
            Routes.RECORD,
            arguments: record,
          );
          controller.updateRecords();
        },
        child: FutureBuilder(
          future: CategoryProvider.readCategoryById(record.category!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Category? category = snapshot.data;
            category ??= Category(name: "NA");
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        '${category.emoji}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${category.name}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${record.note}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat.yMMMMd().format(
                            DateConstant.dateStringToDateTime(record.dateTime!),
                          ),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Text(
                          "₹ ${record.amount}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat.jm().format(
                            DateConstant.dateStringToDateTime(record.dateTime!),
                          ),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
