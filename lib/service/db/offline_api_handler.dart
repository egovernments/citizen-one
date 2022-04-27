

import 'package:dio/dio.dart';
import 'package:edge_client/modules/water_service/core_handler.dart';
import 'package:egov_widgets/components/network_connectivity.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/enums.dart';
import 'property_service.dart';
import 'water_service.dart';

class OfflineApiHandler {

  factory OfflineApiHandler() {
    return _singleton;
  }

  OfflineApiHandler._internal();

  static final OfflineApiHandler _singleton = OfflineApiHandler._internal();
  Future<Database>? _dataBase;

  Future<Response> requestSegregation(RequestOptions options) async {
    await initiateDataBase();
   switch(validateTheService(options)){
     case ServiceType.waterService:
       return await WaterServiceDbHandler().executeDbOperations(options, _dataBase!);
     case ServiceType.propertyService:
       return await PropertyServiceDbHandler().executeDbOperations(options, _dataBase!);
     case ServiceType.tradeLicence:
       break;
     case ServiceType.coreService:
       return await CoreDbHandler().executeDbOperations(options, _dataBase!);
     default:
       throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
   }
   return Response(requestOptions: options);
  }

  Future initiateDataBase() async {
    _dataBase ??= openDatabase(
      join(await getDatabasesPath(), 'citizen.db'),
      onCreate: (db, version) async {
        Batch batch = db.batch();
        String script =  await rootBundle.loadString("assets/db/script.sql");
        List<String> scripts = script.split(";");
        for (var v in scripts) {
          if(v.isNotEmpty )
          {
            batch.execute(v.trim());
          }
        }
        await batch.commit();
      },
      version: 1,
    );
  }

  ServiceType validateTheService(RequestOptions options) {
    if(!options.headers.containsKey('serviceType')) {
      throw DioError(requestOptions: options, type: DioErrorType.other, error: 'service Type required');
    } else {
      var serviceTye = ServiceType.values.where((service) => service.toString().split('.').last == options.headers['serviceType']).toList();
      return serviceTye.isNotEmpty ? serviceTye.first : throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
    }
  }


  static Future<void> sync([bool? isConnected]) async {
    if((isConnected == null && !(await NetworkConnectivity.isConnected())) || !(isConnected ?? true)) return;
    PropertyServiceDbHandler().syncData();
  }
}