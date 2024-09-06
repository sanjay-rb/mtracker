import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/providers/account_provider.dart';
import 'package:mtracker/app/widgets/text_input_field_widget.dart';

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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextInputFieldWidget(
                      hint: account == null ? 'Emoji' : account!.emoji!,
                      textEditingController: controller.emojiController,
                      type: TextInputType.text,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: TextInputFieldWidget(
                      hint: account == null ? 'Name' : account!.name!,
                      textEditingController: controller.nameController,
                      type: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextInputFieldWidget(
                hint: account == null ? 'Balance' : account!.balance.toString(),
                textEditingController: controller.nameController,
                type: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  if (account != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text("DELETE"),
                          onPressed: () async {
                            if (controller.validateForm()) {
                              await AccountProvider.deleteAccount(account!);
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
