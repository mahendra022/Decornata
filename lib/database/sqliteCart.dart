// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// class SQLCart with ChangeNotifier {
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""CREATE TABLE items(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         productID INTEGER,
//         title TEXT,
//         qty INTEGER,
//         price INTEGER,
//         image TEXT,
//         selected INTEGER NOT NULL DEFAULT 0 CHECK(is_friend IN (0,1),
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }

//   static Future<sql.Database> db() async {
//     return sql.openDatabase(
//       'cart.db',
//       version: 1,
//       onCreate: (sql.Database database, int version) async {
//         await createTables(database);
//       },
//     );
//   }

//   // Create database
//   static Future<int> createItem(
//       String title, String? amount, String? type, String? descrption) async {
//     final db = await SQLCart.db();


//     final data = {
//       'title': title,
//       'amount': amount,
//       'type': type,
//       'description': descrption,
//     };



//     final id = await db.insert('items', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   // get semua data
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLCart.db();
//     return db.query('items', orderBy: "id");
//   }

//   // get data berdasarkan id
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SQLCart.db();
//     return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
//   }

// // update data
//   static Future<int> updateItem(int id, String title, String? amount,
//       String? type, String? descrption) async {
//     final db = await SQLCart.db();

//     final data = {
//       'title': title,
//       'amount': amount,
//       'type': type,
//       'description': descrption,
//       'createdAt': DateTime.now().toString()
//     };

//     final result =
//         await db.update('items', data, where: "id = ?", whereArgs: [id]);
//     return result;
//   }

// // hapus data
//   static Future<void> deleteItem(int id) async {
//     final db = await SQLCart.db();
//     try {
//       await db.delete("items", where: "id = ?", whereArgs: [id]);
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
// }
