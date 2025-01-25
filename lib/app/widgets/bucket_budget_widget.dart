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
                    "Total Credit :",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Text(
                    "₹ 0.00",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1 - .5),
          child: SizedBox(
            width: Get.size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Needs :",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  Text(
                    "₹ 0.00",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1 - .3),
          child: SizedBox(
            width: Get.size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wants :",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  Text(
                    "₹ 0.00",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1 - .2),
          child: SizedBox(
            width: Get.size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saves :",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  Text(
                    "₹ 0.00",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1),
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
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  Text(
                    "₹ 0.00",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
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
