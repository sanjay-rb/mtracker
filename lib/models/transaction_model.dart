// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mtracker/services/gsheet_service.dart';

class TransactionModel {
  static const dbLink =
      "https://docs.google.com/spreadsheets/d/1SE5pbs8gcUBVQUxHMvfKvNl2p53hJ0iwa6y2-NitPIU/edit#gid=538661862";

  static Future<bool> addTransaction(
    TransactionModel transactionModel,
  ) async {
    return await GSheetService.transactionSheet!.values.map
        .appendRows([transactionModel.toMap()]);
  }

  static Future<bool> updateTransaction(
    TransactionModel transactionModel,
  ) async {
    return GSheetService.transactionSheet!.values.map.insertRowByKey(
      transactionModel.id,
      transactionModel.toMap(),
    );
  }

  static Future<bool> deleteTransaction(
    TransactionModel transactionModel,
  ) async {
    final index = await GSheetService.transactionSheet!.values.rowIndexOf(
      transactionModel.id,
    );
    return GSheetService.transactionSheet!.deleteRow(index);
  }

  static Future<List<TransactionModel>> getMonthTransaction() async {
    List<Map<String, String>>? rows =
        await GSheetService.monthTransactionSheet!.values.map.allRows();
    if (rows![0]['id']!.contains("#N/A")) {
      return [];
    }
    return rows.map((e) => TransactionModel.fromMap(e)).toList();
  }

  String id;
  String amount;
  String type;
  String dateTime;
  String note;
  String category;
  String fromAccount;
  String toAccount;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.dateTime,
    required this.note,
    required this.category,
    required this.fromAccount,
    required this.toAccount,
  });

  TransactionModel copyWith({
    String? id,
    String? amount,
    String? type,
    String? dateTime,
    String? note,
    String? category,
    String? fromAccount,
    String? toAccount,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      note: note ?? this.note,
      category: category ?? this.category,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'type': type,
      'dateTime': dateTime,
      'note': note,
      'category': category,
      'fromAccount': fromAccount,
      'toAccount': toAccount,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amount: map['amount'] as String,
      type: map['type'] as String,
      dateTime: map['dateTime'] as String,
      note: map['note'] as String,
      category: map['category'] as String,
      fromAccount: map['fromAccount'] as String,
      toAccount: map['toAccount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, type: $type, dateTime: $dateTime, note: $note, category: $category, fromAccount: $fromAccount, toAccount: $toAccount)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.type == type &&
        other.dateTime == dateTime &&
        other.note == note &&
        other.category == category &&
        other.fromAccount == fromAccount &&
        other.toAccount == toAccount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        dateTime.hashCode ^
        note.hashCode ^
        category.hashCode ^
        fromAccount.hashCode ^
        toAccount.hashCode;
  }
}
