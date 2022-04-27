import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/options.dart';

import 'package:dio/src/response.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:egov_widgets/mixin/helper_methods.dart';
import 'package:egov_widgets/utils/models.dart';

import 'package:sqflite_common/sqlite_api.dart';

import '../../service/utils/abstract_db_handler.dart';

class CoreDbHandler extends DbHandler {

  factory CoreDbHandler() {
    return _singleton;
  }

  CoreDbHandler._internal();

  static final CoreDbHandler _singleton = CoreDbHandler._internal();
  late Future<Database> _dataBase;
  static String tableName = 'mdms';

  @override
  Future<Response> executeDbOperations(RequestOptions options, Future<Database> dataBase) async {
    _dataBase = dataBase;
    return await requestSegregation(options);
  }

  @override
  Future<Response> requestSegregation(RequestOptions options) async {
    switch (options.path) {
      case ApiEndPoints.MDMS :
        return await performCrudOperation(options);
      default :
        throw DioError(requestOptions: options,
            type: DioErrorType.other,
            error: 'not found');
    }
  }

  @override
  Future<Response> performCrudOperation(RequestOptions options) async {
    Database db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method);
    var response;

    try {
      final List<dynamic> mdmsData = await db.query(tableName,
      );

      switch(requestType){
        case RequestType.GET:
          return Response(requestOptions: options, data: mdmsData, statusCode: 200);
        case RequestType.PUT :
          Map filteredData = options.data;
          if(mdmsData is List && mdmsData.isNotEmpty) {
             filteredData = jsonDecode(mdmsData.first['mdms']) as Map;
            var apiData = options.data as Map;
             filteredData['MdmsRes'].addAll(apiData['MdmsRes']);
          }
          response =  await db.insert(
            tableName,
            {
              "localId" : 1,
              "mdms":  jsonEncode(filteredData)
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.POST:
        return Response(requestOptions: options, data: mdmsData.isNotEmpty ? jsonDecode(mdmsData.last['mdms']) : null, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

  @override
  Future<bool> syncData() async {
   return true;
  }


}