

import 'package:dio/dio.dart';

import '../../utils/enums.dart';
import 'water_service.dart';

class OfflineApiHandler {

  Future<Response> requestSegregation(RequestOptions options) async {
   switch(validateTheService(options)){
     case ServiceType.waterService:
       return await WaterServiceDbHandler.requestSegregation(options);
       break;
     case ServiceType.propertyService:

       break;
     case ServiceType.tradeLicence:

       break;
     default:
       throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
   }
   return Response(requestOptions: options);
  }

  ServiceType validateTheService(RequestOptions options) {
    if(!options.headers.containsKey('serviceType')) {
      throw DioError(requestOptions: options, type: DioErrorType.other, error: 'service Type required');
    } else {
      var serviceTye = ServiceType.values.where((service) => service.toString().split('.').last == options.headers['serviceType']).toList();
      return serviceTye.isNotEmpty ? serviceTye.first : throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
    }
  }
}