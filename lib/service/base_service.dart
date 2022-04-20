import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:edge_client/environments/env.dart';
import 'package:egov_widgets/utils/custom_exception.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:flutter/cupertino.dart';

import '../utils/global_variables.dart';

class BaseService {
  Future<dynamic> makeRequest<T>(
      {required String url,
      String? baseUrl,
      dynamic body,
      String? contentType,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      RequestType method = RequestType.GET,
      dynamic? requestInfo, Map<String, dynamic> extras = const {}, bool storeResponseInDb = false}) async {

    dio.options.baseUrl = Environment().config?.apiHost ?? '';
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    dio.options.extra.addAll(extras);
    dio.options.extra['storeResponse'] = storeResponseInDb;
    if(headers != null) dio.options.headers.addAll(headers);

    if (requestInfo != null) {
      if (body != null) {
        body = {"RequestInfo": requestInfo.toJson(), ...body};
      } else {
        body = requestInfo.toJson();
      }
    }

    if (headers == null ||
        dio.options.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      body = jsonEncode(body);
    }

    Response response;
    try {
      switch (method) {
        case RequestType.GET:
          if (queryParameters != null && queryParameters.length > 0) {
            response = await dio.get(
              url,
              queryParameters: queryParameters,
            );
            return response.data;
          }
          response = await dio.get(url);
          return response.data;
        case RequestType.PUT:
          response = await dio.put(url,
              queryParameters: queryParameters, data: body);
          return response.data;
        case RequestType.POST:
          response = await dio.post(
            url,
            queryParameters: queryParameters,
            data: body,
          );
          return response.data;
        case RequestType.DELETE:
          response = await dio.delete(url,
              queryParameters: queryParameters, data: body);
          return response.data;
      }
    } on CustomException catch (e) {
      rethrow;
    } catch (e) {
      throw CustomException('', 502, ExceptionType.CONNECTIONISSUE);
    }
  }
}
