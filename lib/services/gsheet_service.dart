import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:mtracker/constants/assets.dart';
import 'package:mtracker/models/transaction.dart';

class GSheetService {
  static const transactionSheetLink =
      "https://docs.google.com/spreadsheets/d/1SYfxFvKL1DZH7inZHhBl30R0EEwHsQTDqIlsuG34oi4/";
  static const categorySheetLink =
      "https://docs.google.com/spreadsheets/d/1SYfxFvKL1DZH7inZHhBl30R0EEwHsQTDqIlsuG34oi4/edit#gid=1630874817";

  static const dbId = "1SYfxFvKL1DZH7inZHhBl30R0EEwHsQTDqIlsuG34oi4";
  static Worksheet? transactionSheet;
  static Worksheet? monthTransactionSheet;
  static Worksheet? totalSheet;
  static Worksheet? categorySheet;

  static Future init() async {
    String key = await rootBundle.loadString(Assets.assetsKey);
    final gsheet = GSheets(key);
    final spreadsheet = await gsheet.spreadsheet(dbId);
    transactionSheet = await getWorksheet(spreadsheet, 'Transaction');
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

  static Future<bool> addTransaction(
    TransactionModel transactionModel,
  ) async {
    return await transactionSheet!.values.map
        .appendRows([transactionModel.toMap()]);
  }

  static Future<bool> updateTransaction(
    TransactionModel transactionModel,
  ) async {
    return transactionSheet!.values.map
        .insertRowByKey(transactionModel.id, transactionModel.toMap());
  }

  static Future<bool> deleteTransaction(
    TransactionModel transactionModel,
  ) async {
    final index =
        await transactionSheet!.values.rowIndexOf(transactionModel.id);
    return transactionSheet!.deleteRow(index);
  }

  static Future<List<TransactionModel>> getMonthTransaction() async {
    List<Map<String, String>>? rows =
        await monthTransactionSheet!.values.map.allRows();
    if (rows![0]['id']!.contains("#N/A")) {
      return [];
    }
    return rows.map((e) => TransactionModel.fromMap(e)).toList();
  }

  static Future<List<String>> getAllCategory() async {
    List<String> returnList = [];
    List<List<String>>? row = await categorySheet!.values.allRows(fromRow: 2);
    for (var element in row) {
      returnList.add(element[0]);
    }
    return returnList;
  }
}
