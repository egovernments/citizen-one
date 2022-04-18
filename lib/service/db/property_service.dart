
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge_client/repository/property_repo.dart';
import 'package:edge_client/service/utils/abstract_db_handler.dart';
import 'package:edge_client/service/utils/model.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/consumer.dart';
import '../utils/api_end_points.dart';

class PropertyServiceDbHandler implements DbHandler {

  factory PropertyServiceDbHandler() {
    return _singleton;
  }

  PropertyServiceDbHandler._internal();

  static final PropertyServiceDbHandler _singleton = PropertyServiceDbHandler._internal();
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
  Future<bool> syncData() async {
    Database db = await _dataBase;
    final List<Map<String, dynamic>> maps = await db.query('property',
    );
    if(maps.isEmpty) return true;
    var res = await UserRepository().consumerCreateOrUpdate(setConsumersFilteredData(maps));
    if(res != null){
      db.delete('property');
      return true;
    }else{
      return false;
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
          var filteredData = setConsumersFilteredData(maps);
          if(options.queryParameters['searchPattern'] != null && options.queryParameters['searchPattern'].toString().isNotEmpty) filteredData = filteredData.where((e) => e['name'].toString().contains(options.queryParameters['searchPattern'])).toList();
          return Response(requestOptions: options, data: filteredData, statusCode: 200);
        // case RequestType.PUT:
        //   var consumer = jsonDecode(options.data);
        //   consumer['street'] = consumer['address']['street'];
        //   consumer['zipcode'] = consumer['address']['zipcode'];
        //   consumer.remove('address');
        // response = await db.update(
        //     'property',
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

   setConsumersFilteredData(List<Map<String, dynamic>> maps) {
    return maps.map((e) {
      var consumer = {...e};
      consumer['address'] = <String, dynamic>{};
      consumer['address']['street'] = e['street'];
      consumer['address']['zipcode'] = e['zipcode'];
      return consumer;
    }).toList();
  }


}