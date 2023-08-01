import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:mtracker/constants/assets.dart';

class GSheetService {
  static const dbId = "1SE5pbs8gcUBVQUxHMvfKvNl2p53hJ0iwa6y2-NitPIU";
  static Worksheet? transactionSheet;
  static Worksheet? monthTransactionSheet;
  static Worksheet? totalSheet;
  static Worksheet? categorySheet;
  static Worksheet? accountSheet;

  static Future init() async {
    String key = await rootBundle.loadString(Assets.assetsKey);
    final gsheet = GSheets(key);
    final spreadsheet = await gsheet.spreadsheet(dbId);
    transactionSheet = await getWorksheet(spreadsheet, 'Transaction');
    accountSheet = await getWorksheet(spreadsheet, 'Account');
    monthTransactionSheet =
        await getWorksheet(spreadsheet, 'Month Transaction');
    totalSheet = await getWorksheet(spreadsheet, 'Total');
    categorySheet = await getWorksheet(spreadsheet, 'Category');
  }

  static Future<Worksheet> getWorksheet(
      Spreadsheet sheets, String title) async {
    try {
      return await sheets.addWorksheet(title);
    } catch (e) {
      return sheets.worksheetByTitle(title)!;
    }
  }

  static Future<Map<String, String>> getTotal() async {
    Map<String, String>? row = await totalSheet!.values.map.lastRow();
    return row!;
  }
}
