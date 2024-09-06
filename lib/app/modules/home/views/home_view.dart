import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/app/constants/date_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';
import 'package:mtracker/app/data/providers/category_provider.dart';
import 'package:mtracker/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(Routes.RECORD, arguments: null);
          controller.updateRecords();
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
              icon: Icon(Icons.account_balance),
              label: "Accounts",
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
                      Text(
                        "${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().year}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const Divider(),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
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
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1 - .5),
                        child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Needs :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1 - .3),
                        child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wants :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1 - .2),
                        child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Saves :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1 - .1),
                        child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Unknown :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1),
                        child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Debit :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                Text(
                                  "₹ 10,000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Obx(
                          () => Column(
                            children: List.generate(
                              controller.records.length,
                              (index) {
                                TransactionRecord record =
                                    controller.records[index];
                                String dateTimeStr =
                                    DateConstant.dateTimeFormat.format(
                                  DateConstant.dateStringToDateTime(
                                    record.dateTime!,
                                  ),
                                );
                                return InkWell(
                                  onTap: () async {
                                    await Get.toNamed(
                                      Routes.RECORD,
                                      arguments: record,
                                    );
                                    controller.updateRecords();
                                  },
                                  child: FutureBuilder(
                                    future: AccountProvider.readAccountById(
                                        record.account!),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      Account? account = snapshot.data;
                                      account ??= Account(name: "NA");
                                      return FutureBuilder(
                                        future:
                                            CategoryProvider.readCategoryById(
                                                record.category!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          Category? category = snapshot.data;
                                          category ??= Category(name: "NA");
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: Text(
                                                      '${category.emoji}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${category.name}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        "${record.note}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        dateTimeStr,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "₹ ${record.amount}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              color: record
                                                                          .type! ==
                                                                      TypeConstant
                                                                          .credit
                                                                  ? Colors.green
                                                                  : record.type! ==
                                                                          TypeConstant
                                                                              .debit
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        "${account!.name}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
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
                      Row(
                        children: [
                          Text(
                            "ACCOUNTS",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await Get.toNamed(
                                Routes.ACCOUNT,
                                arguments: null,
                              );
                              controller.updateAccounts();
                            },
                            label: const Text("Add"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
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
                      Obx(
                        () => Column(
                          children: List.generate(
                            controller.accounts.length,
                            (index) {
                              Account account = controller.accounts[index];
                              return InkWell(
                                onTap: () async {
                                  await Get.toNamed(
                                    Routes.ACCOUNT,
                                    arguments: account,
                                  );
                                  controller.updateAccounts();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        account.emoji.toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        account.name.toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹ ${account.balance}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "CATEGORIES",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await Get.toNamed(
                                Routes.CATEGORY,
                                arguments: null,
                              );
                              controller.updateCategories();
                            },
                            label: const Text("Add"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
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
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              category.defaultRecordType ==
                                                      TypeConstant.credit
                                                  ? const TextSpan(text: "🟢")
                                                  : const TextSpan(),
                                              category.defaultRecordType ==
                                                      TypeConstant.debit
                                                  ? const TextSpan(text: "🔴")
                                                  : const TextSpan(),
                                              category.defaultRecordType ==
                                                      TypeConstant.transfer
                                                  ? const TextSpan(text: "🔵")
                                                  : const TextSpan(),
                                              const TextSpan(text: " "),
                                              TextSpan(
                                                text: category.name.toString(),
                                              ),
                                            ],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
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
