import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/modules/home/controllers/home_controller.dart';

class BucketBudgetWidget extends GetWidget<HomeController> {
  const BucketBudgetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).primaryColor,
          child: SizedBox(
            width: Get.size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Debit :",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Obx(
                    () => Text(
                      "₹ ${controller.totalDebit}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
