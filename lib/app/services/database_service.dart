import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        db.execute("""
          CREATE TABLE [category] (
            [id] TEXT,
            [name] TEXT,
            [emoji] TEXT,
            [rule] TEXT NULL,
            [type] TEXT
          );
        """);

        db.execute("""
          CREATE TABLE [transaction_record] (
              [id] TEXT,
              [type] TEXT,
              [amount] REAL,
              [note] TEXT,
              [source_account] TEXT,
              [target_account] TEXT,
              [category] TEXT,
              [rule] TEXT,
              [date_time] TEXT
          );
        """);

        resetDatabase(db);
      },
    );
    return database;
  }

  resetDatabase(Database db) async {
    db.delete(Category.TABLE_NAME);
    db.delete(TransactionRecord.TABLE_NAME);

    db.rawInsert('''
      INSERT INTO [account] ([id], [name], [emoji], [balance])
      VALUES ('A20240903104201', 'Primary Account', '🏦', 0),
        ('A20240903104202', 'Secondary Account', '🏦', 0),
        ('A20240903104203', 'Wallet', '👛', 0),
        ('A20240903104204', 'Primary Credit Card', '💳', 0),
        ('A20240903104205', 'Secondary Credit Card', '💳', 0);
    ''');

    db.rawInsert('''
      INSERT INTO [category] ([id], [name], [emoji], [rule], [type])
      VALUES ('C20240903104201', 'Salary', '💵', 'NR', 'CREDIT'),
        ('C20240903104202', 'Food', '🍔', 'WANTS', 'DEBIT'),
        ('C20240903104203', 'Grocery', '🛒', 'NEEDS', 'DEBIT'),
        ('C20240903104204', 'Gold', '💰', 'SAVES', 'DEBIT'),
        ('C20240903104205', 'Stocks', '📈', 'SAVES', 'DEBIT'),
        ('DEFAULT_TRANSFER_CATEGORY', 'Transfer', '🔃', 'NR', 'TRANSFER');
    ''');
  }
}
