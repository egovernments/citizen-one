
import 'package:dio/dio.dart';
import 'package:egov_widgets/components/network_connectivity.dart';
import '../utils/global_variables.dart';
import 'db/offline_api_handler.dart';

initiateInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async {
          // Do something before request is sent
          if(await NetworkConnectivity.isConnected()) {
            return handler.next(options);
          }else{
            return handler.resolve(await OfflineApiHandler().requestSegregation(options));
          }
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          // Do something with response data
          if(response.requestOptions.extra['storeResponse']){
            response.requestOptions.data = response.data;
            response.requestOptions.method = 'PUT';
            OfflineApiHandler().requestSegregation(response.requestOptions);
          }
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));
  }