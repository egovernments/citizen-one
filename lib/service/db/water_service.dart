
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge_client/repository/consumer_repo.dart';
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
      default :
        throw DioError(requestOptions: options, type: DioErrorType.other, error: 'not found');
    }
  }


  static Future initiateConsumerDataBase() async {
    _dataBase = openDatabase(
      join(await getDatabasesPath(), 'consumers_local_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE consumers(localId INTEGER PRIMARY KEY AUTOINCREMENT, id INTEGER, name TEXT, username TEXT, email INTEGER, phone TEXT, street TEXT, zipcode TEXT)',
        );
      },
      version: 1,
    );
  }

  static syncData() async {
    if(!(await NetworkConnectivity.isConnected())) return;
    if(_dataBase == null) await initiateConsumerDataBase();
    Database db = await _dataBase;
    final List<Map<String, dynamic>> maps = await db.query('consumers',
    );
    var res = await ConsumerRepository().consumerCreateOrUpdate(setConsumersFilteredData(maps));
    if(res != null){
      db.delete('consumers');
    }
  }

  static Future<Response> insertOrUpdateConsumer(RequestOptions options) async {
    Database db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method);
    var response;
    try {
      switch(requestType){
        case RequestType.GET:
          final List<Map<String, dynamic>> maps = await db.query('consumers',
          );
          var filteredData = setConsumersFilteredData(maps);
          if(options.queryParameters['searchPattern'] != null && options.queryParameters['searchPattern'].toString().isNotEmpty) filteredData = filteredData.where((e) => e['name'].toString().contains(options.queryParameters['searchPattern'])).toList();
          return Response(requestOptions: options, data: filteredData, statusCode: 200);
        // case RequestType.PUT:
        //   var consumer = jsonDecode(options.data);
        //   consumer['street'] = consumer['address']['street'];
        //   consumer['zipcode'] = consumer['address']['zipcode'];
        //   consumer.remove('address');
        // response = await db.update(
        //     'consumers',
        //   consumer,
        //     where: 'id = ?',
        //     whereArgs: [options.data['id'].toString()],
        //   );
        //   return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.POST: case RequestType.PUT:
          var consumer = jsonDecode(options.data);
          consumer['street'] = consumer['address']['street'];
          consumer['zipcode'] = consumer['address']['zipcode'];
          consumer.remove('address');
        response =  await db.insert(
            'consumers',
          consumer,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        return Response(requestOptions: options, data: response, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

  static setConsumersFilteredData(List<Map<String, dynamic>> maps) {
    return maps.map((e) {
      var consumer = {...e};
      consumer['address'] = <String, dynamic>{};
      consumer['address']['street'] = e['street'];
      consumer['address']['zipcode'] = e['zipcode'];
      return consumer;
    }).toList();
  }


}