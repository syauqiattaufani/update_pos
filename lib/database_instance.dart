import 'dart:io' as io;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:project_pos/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_pos/model.dart';

class DatabaseInstance {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "users.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "users.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM cashier_dbf');
    List<Employee> employees = [];
    for (int i = 0; i < list.length; i++) {
      employees.add(new Employee(list[i]["code"], list[i]["pass"]));
    }
    return employees;
  }

  // Future initDb() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, "users.db");

  //   final exists = await databaseExists(path);

  //   if (exists) {
  //     // Should happen only the first time you launch your application
  //     print("Creating new copy from asset");
  //   } else {
  //     print("Creating a copy from assets");
  //     // Make sure the parent directory exists
  //     try {
  //       await Directory(dirname(path)).create(recursive: true);
  //     } catch (_) {}

  //     // Copy from asset
  //     ByteData data = await rootBundle.load(join("/assets", "users.db"));
  //     List<int> bytes =
  //         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  //     // Write and flush the bytes written
  //     await File(path).writeAsBytes(bytes, flush: true);
  //     print("Db copied");
  //   }
  //   // open the database
  //   await openDatabase(
  //     path,
  //     onOpen: (db) => '/assets/users.db',
  //   );
  //   // var db = await openDatabase('users.db');
  // }
}
