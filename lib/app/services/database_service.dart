import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/constants/assets_constant.dart';
import 'package:mtracker/app/constants/rule_constant.dart';
import 'package:mtracker/app/constants/type_constant.dart';
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
        db.rawInsert('''
          INSERT INTO [account] ([name],[emoji],[balance])
          VALUES
          ('Primary Account','🏦',0),
          ('Secondary Account','🏦',0),
          ('Wallet','👛',0),
          ('Primary Credit Card','💳',0),
          ('Secondary Credit Card','💳',0);
        ''');

        final budgetBucketDDL =
            await rootBundle.loadString(Assets.assetsSqlBudgetBucket);
        db.execute(budgetBucketDDL);

        final categoryDDL =
            await rootBundle.loadString(Assets.assetsSqlCategory);
        db.execute(categoryDDL);

        db.rawInsert('''
          INSERT INTO [category] ([name],[emoji],[default_rule_bucket],[default_record_type])
          VALUES
          ('Salary','💵','${RuleConstant.na}','${TypeConstant.credit}'),
          ('Food','🍔','${RuleConstant.wants}','${TypeConstant.debit}'),
          ('Grocery','🛒','${RuleConstant.needs}','${TypeConstant.debit}'),
          ('Gold','💰','${RuleConstant.saves}','${TypeConstant.transfer}'),
          ('Stocks','📈','${RuleConstant.saves}','${TypeConstant.transfer}');
        ''');

        final recordDDL = await rootBundle.loadString(Assets.assetsSqlRecord);
        db.execute(recordDDL);
      },
    );
    return database;
  }

  deleteDataBase() async {
    String directory = await getDatabasesPath();
    String dbPath = join(directory, 'mtracker.bank');
    debugPrint("DB PATH : ${dbPath.toString()}");
    databaseFactory.deleteDatabase(dbPath);
  }
}
