import 'package:budget_bee/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'transaction.db'),
        onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL,date TEXT)''');
    }, version: 1);
  }

  Future<void> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> fetchTransaction() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return TransactionModel(
          id: maps[i]['id'],
          title: maps[i]['title'],
          amount: maps[i]['amount'],
          date: DateTime.parse(
            maps[i]['date'],
          ));
    });
  }
}
