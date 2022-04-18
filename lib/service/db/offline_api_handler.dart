

import 'package:dio/dio.dart';
import 'package:egov_widgets/components/network_connectivity.dart';

import '../../utils/enums.dart';
import 'property_service.dart';

class OfflineApiHandler {

  Future<Response> requestSegregation(RequestOptions options) async {
   switch(validateTheService(options)){
     case ServiceType.waterService:
       return await PropertyServiceDbHandler().requestSegregation(options);
     case ServiceType.propertyService:
       return await PropertyServiceDbHandler().requestSegregation(options);
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


  static Future<void> sync([bool? isConnected]) async {
    if((isConnected == null && !(await NetworkConnectivity.isConnected())) || !(isConnected ?? true)) return;
    PropertyServiceDbHandler().syncData();
  }
}