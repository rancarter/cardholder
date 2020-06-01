import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsDB {
  final tableName = 'credit_cards';

  Database db;

  Future<void> openDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'cards_wallet.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, number TEXT)",
        );
      },
      version: 1,
    );

    print(db);
  }

  Future<void> closeDB() => db.close();

  Future<int> insertCard(Map<String, dynamic> creditCard) async {
    return db.insert(
      tableName,
      creditCard,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCard(num id, Map<String, dynamic> creditCard) async {
    return db.update(
      tableName,
      creditCard,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteCards(List<num> ids) async {
    final idsString = ids.join(', ');
    return db.delete(
      tableName,
      where: "id = ?",
      whereArgs: ids,
    );
  }

  Future<List<Map<String, dynamic>>> getCreditCards() => db.query(tableName);
}
