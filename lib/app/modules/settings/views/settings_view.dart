import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/services/database_service.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "⚙️ SETTINGS",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text("Export Data as CSV"),
                        onPressed: () async {
                          await controller.exportToCSV();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("Reset Database"),
                        onPressed: () async {
                          bool isReset = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Reset Database"),
                                content: const Text(
                                  "Are you sure you want to reset the database? This action cannot be undone.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        color: Colors.red.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          if (isReset) {
                            DatabaseService service = DatabaseService();
                            var db = await service.database;
                            await service.resetDatabase(db);
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
