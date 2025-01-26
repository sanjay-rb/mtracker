import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/services/database_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsController extends GetxController {
  // Export the users table as a CSV file
  Future<void> exportToCSV() async {
    PermissionStatus permissionStatus =
        await Permission.manageExternalStorage.request();
    if (!permissionStatus.isGranted) {
      await openAppSettings();
    }

    var db = await DatabaseService().database;

    // Query the table (get all records)
    final List<Map<String, dynamic>> result =
        await db.query('transaction_record');

    // Convert the data into CSV format
    List<List<dynamic>> rows = [];
    rows.add(
      ['id', 'amount', 'note', 'category', 'date_time'],
    ); // Column headers

    for (var row in result) {
      rows.add([
        row['id'],
        row['amount'],
        row['note'],
        row['category'],
        row['date_time'],
      ]);
    }

    // Convert the rows to CSV string
    String csv = const ListToCsvConverter().convert(rows);

    Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');
    if (!downloadsDirectory.existsSync()) {
      Get.snackbar('ERROR', "Failed to get Downloads directory.");
      return;
    }

    // Write the CSV string to the file
    final file = File('${downloadsDirectory.path}/transaction_record.csv');
    await file.writeAsString(csv);
    //
    Get.snackbar(
      'INFO',
      "transaction_record.csv File downloaded in Download folder.",
    );
  }
}
