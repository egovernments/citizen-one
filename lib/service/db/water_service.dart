
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:edge_client/service/utils/abstract_db_handler.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:egov_widgets/mixin/helper_methods.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class WaterServiceDbHandler extends DbHandler{

  factory WaterServiceDbHandler() {
    return _singleton;
  }

  WaterServiceDbHandler._internal();

  static final WaterServiceDbHandler _singleton = WaterServiceDbHandler._internal();
  late Future<Database> _dataBase;

  @override
  Future<Response> executeDbOperations(RequestOptions options, Future<Database> dataBase) async {
   _dataBase = dataBase;
   return await requestSegregation(options);
  }

  @override
  Future<Response> requestSegregation(RequestOptions options) async {
    switch(options.path){
      case ApiEndPoints.propertyTax :
        return await performCrudOperation(options);
      default :
        throw DioError(requestOptions: options, type: DioErrorType.other, error: 'not found');
    }
  }

  @override
  Future<Response> performCrudOperation(RequestOptions options) async {
    Database db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method);
    var response;
    try {
      switch(requestType){
        case RequestType.GET:
          final List<Map<String, dynamic>> maps = await db.query('property',
          );
          return Response(requestOptions: options, data: maps, statusCode: 200);
        case RequestType.POST: case RequestType.PUT:
        var consumer = jsonDecode(options.data);
        consumer['street'] = consumer['address']['street'];
        consumer['zipcode'] = consumer['address']['zipcode'];
        consumer.remove('address');
        response =  await db.insert(
          'property',
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

  @override
  Future<bool> syncData() {
    // TODO: implement syncData
    throw UnimplementedError();
  }
}