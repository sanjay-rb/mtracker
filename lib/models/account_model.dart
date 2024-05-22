// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mtracker/services/gsheet_service.dart';

class AccountModel {
  static const dbLink =
      "https://docs.google.com/spreadsheets/d/1SE5pbs8gcUBVQUxHMvfKvNl2p53hJ0iwa6y2-NitPIU/edit?usp=sharing#gid=0";

  static Future<List<AccountModel>> getAllAccount() async {
    List<Map<String, String>>? rows =
        await GSheetService.accountSheet!.values.map.allRows();
    return rows!.map((e) => AccountModel.fromMap(e)).toList();
  }

  String account;
  String currentBalance;
  String previousBalance;
  AccountModel({
    required this.account,
    required this.currentBalance,
    required this.previousBalance,
  });

  AccountModel copyWith({
    String? account,
    String? currentBalance,
    String? previousBalance,
  }) {
    return AccountModel(
      account: account ?? this.account,
      currentBalance: currentBalance ?? this.currentBalance,
      previousBalance: previousBalance ?? this.previousBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'account': account,
      'currentBalance': currentBalance,
      'previousBalance': previousBalance,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      account: map['account'] as String,
      currentBalance: map['currentBalance'] as String,
      previousBalance: map['previousBalance'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AccountModel(account: $account, currentBalance: $currentBalance, previousBalance: $previousBalance)';

  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;

    return other.account == account &&
        other.currentBalance == currentBalance &&
        other.previousBalance == previousBalance;
  }

  @override
  int get hashCode =>
      account.hashCode ^ currentBalance.hashCode ^ previousBalance.hashCode;
}
