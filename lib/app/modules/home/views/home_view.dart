import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/routes/app_pages.dart';
import 'package:mtracker/app/services/database_service.dart';
import 'package:mtracker/app/widgets/bucket_budget_widget.dart';
import 'package:mtracker/app/widgets/record_list_tile_widget.dart';

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
                              // TODO: Filter
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
                                    return RecordListTileWidget(index: index);
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
