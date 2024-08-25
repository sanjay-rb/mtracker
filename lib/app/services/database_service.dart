import 'package:mtracker/app/data/models/bucket_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await setDatabase();
    return _database!;
  }

  setDatabase() async {
    String directory = await getDatabasesPath();
    String dbPath = join(directory, 'mtracker.bank');
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
          CREATE TABLE "bucket" (
            "name" varchar,
            "emoji" varchar,
            "balance" integer,
            "label" varchar
          );

          CREATE TABLE "record" (
            "id" integer PRIMARY KEY,
            "amount" integer,
            "type" varchar,
            "rule" varchar,
            "dt" datetime,
            "notes" varchar,
            "from_bucket" varchar,
            "to_bucket" varchar
          );
        ''';
        db.execute(sql);
        List<Bucket> defaultBucket = [
          Bucket(
            name: "Primary Account",
            emoji: "🏦",
            balance: 0,
            label: "account",
          ),
          Bucket(
            name: "Secondary Account",
            emoji: "🏦",
            balance: 0,
            label: "account",
          ),
          Bucket(
            name: "Wallet",
            emoji: "👝",
            balance: 0,
            label: "account",
          ),
          Bucket(
            name: "Card",
            emoji: "💳",
            balance: 0,
            label: "account",
          ),
          Bucket(
            name: "Food",
            emoji: "🍔",
            balance: 0,
            label: "wants",
          ),
          Bucket(
            name: "Grocery",
            emoji: "🛒",
            balance: 0,
            label: "needs",
          ),
        ];
        for (Bucket element in defaultBucket) {
          db.insert('bucket', element.toJson());
        }
      },
    );
    return database;
  }
}
