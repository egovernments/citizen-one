
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge_client/service/utils/model.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/consumer.dart';
import '../utils/api_end_points.dart';

class WaterServiceDbHandler {
  static dynamic _dataBase;

  static Future<Response> requestSegregation(RequestOptions options) async {
   if(_dataBase == null) await initiateConsumerDataBase();
    switch(options.path){
      case ApiEndPoints.consumer :
        return await insertOrUpdateConsumer(options);
        break;
      default :
        throw DioError(requestOptions: options, type: DioErrorType.other, error: 'not found');
    }
  }


  static Future initiateConsumerDataBase() async {
    _dataBase = openDatabase(
      join(await getDatabasesPath(), 'consumers_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE consumers(id INTEGER PRIMARY KEY AUTOINCREMENT, consumerName TEXT, fatherName TEXT, mobileNumber INTEGER, serviceTYpe TEXT, connectionType TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<Response> insertOrUpdateConsumer(RequestOptions options) async {
    var db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method);
    var response;
    try {
      switch(requestType){
        case RequestType.GET:
          final List<Map<String, dynamic>> maps = await db.query('consumers');

          return Response(requestOptions: options, data: maps, statusCode: 200);
        case RequestType.PUT:
        response = await db.update(
            'consumers',
            options.data,
            // Ensure that the Dog has a matching id.
            where: 'id = ?',
            // Pass the Dog's id as a whereArg to prevent SQL injection.
            whereArgs: [options.data['id']],
          );
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.POST:
        response =  await db.insert(
            'consumers',
          jsonDecode(options.data),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        return Response(requestOptions: options, data: response, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'INternal Exception');
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