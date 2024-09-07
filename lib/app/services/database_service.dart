import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/assets_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
import 'package:mtracker/app/data/models/account_model.dart';
import 'package:mtracker/app/data/models/budget_bucket_model.dart';
import 'package:mtracker/app/data/models/category_model.dart';
import 'package:mtracker/app/data/models/transaction_record_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await setDatabase();
    return _database!;
  }

  setDatabase() async {
    String directory = await getDatabasesPath();
    String dbPath = join(directory, 'mtracker.bank');

    debugPrint("DB PATH : ${dbPath.toString()}");

    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        final accountDDL = await rootBundle.loadString(Assets.assetsSqlAccount);
        db.execute(accountDDL);

        final budgetBucketDDL =
            await rootBundle.loadString(Assets.assetsSqlBudgetBucket);
        db.execute(budgetBucketDDL);

        final categoryDDL =
            await rootBundle.loadString(Assets.assetsSqlCategory);
        db.execute(categoryDDL);

        final recordDDL =
            await rootBundle.loadString(Assets.assetsSqlTransactionRecord);
        db.execute(recordDDL);
      },
    );
    return database;
  }

  resetDatabase() async {
    // String directory = await getDatabasesPath();
    // String dbPath = join(directory, 'mtracker.bank');
    // debugPrint("DB PATH : ${dbPath.toString()}");
    // databaseFactory.deleteDatabase(dbPath);
    var db = await database;
    db.delete(Account.tableName);
    db.delete(Category.tableName);
    db.delete(BudgetBucket.tableName);
    db.delete(TransactionRecord.tableName);

    db.rawInsert('''
          INSERT INTO [account] ([id],[name],[emoji],[balance])
          VALUES
          ('A20240903104201','Primary Account','🏦',0),
          ('A20240903104202','Secondary Account','🏦',0),
          ('A20240903104203','Wallet','👛',0),
          ('A20240903104204','Primary Credit Card','💳',0),
          ('A20240903104205','Secondary Credit Card','💳',0);
        ''');
    db.rawInsert('''
          INSERT INTO [category] ([id],[name],[emoji],[default_rule_bucket],[default_record_type])
          VALUES
          ('C20240903104201','Salary','💵','${RuleConstant.na}','${TypeConstant.credit}'),
          ('C20240903104202','Food','🍔','${RuleConstant.wants}','${TypeConstant.debit}'),
          ('C20240903104203','Grocery','🛒','${RuleConstant.needs}','${TypeConstant.debit}'),
          ('C20240903104204','Gold','💰','${RuleConstant.saves}','${TypeConstant.transfer}'),
          ('C20240903104205','Stocks','📈','${RuleConstant.saves}','${TypeConstant.transfer}');
        ''');
  }
}
