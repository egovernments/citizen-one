import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/consumer.dart';

class DataBase {
   static late final dynamic _dataBase;

   static Future initiateDataBase() async {
    _dataBase = openDatabase(
      join(await getDatabasesPath(), 'consumers_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE consumers(id INTEGER PRIMARY KEY, consumerName TEXT, fatherName TEXT, mobileNumber INTEGER, serviceTYpe TEXT, connectionType TEXT)',
        );
      },
      version: 1,
    );
  }


   static Future insertConsumer(ConsumerDetails consumer) async {
    var db = await _dataBase;
    try {
      await db.insert(
        'consumers',
        {
          "id" : 1,
          "consumerName" : "krishna",
          "fatherName" : "Vijay kumar",
          "mobileNumber" : "9949210191",
          "serviceTYpe" : "metered",
          "connectionType" : "residentail"
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }catch(e){
      print(e);
    }
  }

  static Future getConsumers() async {
    final db = await _dataBase;
    final List<Map<String, dynamic>> maps = await db.query('consumers');

    var consumers = List.generate(maps.length, (i) {
      return ConsumerDetails.fromJson(maps[i]);
    }).toList();
    return consumers;
  }
}
