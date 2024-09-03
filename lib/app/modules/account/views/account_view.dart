import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  final Account? account;
  const AccountView(this.account, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                account == null
                    ? "➕ ADD ACCOUNT"
                    : "${account!.emoji} ${account!.name!.toUpperCase()}",
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
                          hintText: account == null ? 'Emoji' : account!.emoji,
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
                          hintText: account == null ? 'Name' : account!.name,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.balanceController,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: account == null
                        ? 'Balance'
                        : account!.balance.toString(),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  if (account != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await AccountProvider.deleteAccount(account!);
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
                            if (account != null) {
                              account!.name = controller.nameController.text;
                              account!.emoji = controller.emojiController.text;
                              account!.balance = double.parse(
                                  controller.balanceController.text);

                              await AccountProvider.updateAccount(account!);
                            } else {
                              Account newAccountObj = Account();

                              newAccountObj = Account(
                                id: "A${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
                                name: controller.nameController.text,
                                emoji: controller.emojiController.text,
                                balance: double.parse(
                                    controller.balanceController.text),
                              );

                              await AccountProvider.createAccount(
                                  newAccountObj);
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
