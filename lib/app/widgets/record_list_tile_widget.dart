import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';
import 'package:mtracker/app/routes/app_pages.dart';

class RecordListTileWidget extends GetWidget<HomeController> {
  const RecordListTileWidget({super.key, required this.index});

  final int index;

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
            arguments: controller.records[index],
          );
          controller.updateRecords();
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Obx(
                    () => FutureBuilder<CategoryModel>(
                      future: CategoryProvider.readCategoryById(
                          controller.records[index].category!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        CategoryModel category = snapshot.data!;
                        return Text(
                          '${category.emoji}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                      },
                    ),
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
                    Obx(
                      () => FutureBuilder<CategoryModel>(
                        future: CategoryProvider.readCategoryById(
                            controller.records[index].category!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          CategoryModel category = snapshot.data!;
                          return Text(
                            "${category.name}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        "${controller.records[index].note}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        DateFormat.yMMMMd().format(
                          DateConstant.dateStringToDateTime(
                              controller.records[index].dateTime!),
                        ),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
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
                    Obx(
                      () => Text(
                        "₹ ${controller.records[index].amount}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        DateFormat.jm().format(
                          DateConstant.dateStringToDateTime(
                              controller.records[index].dateTime!),
                        ),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
