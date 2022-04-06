import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:egov_widgets/utils/custom_exception.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class BaseService {
  Future<dynamic> makeRequest<T>(
      {@required String? url,
      String? baseUrl,
      dynamic body,
      String? contentType,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      RequestType method = RequestType.GET,
      dynamic? requestInfo}) async {
    var uri;

    if (queryParameters == null) {
      uri = Uri.parse('$baseUrl$url');
    } else {
      String queryString = Uri(queryParameters: queryParameters).query;
      uri = Uri.parse(
          '${baseUrl != null ? baseUrl : baseUrl}$url?$queryString');
      // uri = Uri.https(apiBaseUrl, url!,  queryParameters);
    }

    if (requestInfo != null) {
      if (body != null) {
        body = {"RequestInfo": requestInfo.toJson(), ...body};
      } else {
        body = requestInfo.toJson();
      }
    }

    if (headers == null ||
        headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      body = jsonEncode(body);
    }

    var header = headers ??
        {
          HttpHeaders.contentTypeHeader: 'application/json',
        };

    http.Response response;
    try {
      switch (method) {
        case RequestType.GET:
          response = await http.get(uri);
          break;
        case RequestType.PUT:
          response = await http.put(uri, body: json.encode(body));
          break;
        case RequestType.POST:
          response = await http.post(uri, headers: header, body: body);
          break;
        case RequestType.DELETE:
          response = await http.delete(uri, body: json.encode(body));
      }
      return _response(response);
    } on CustomException catch (e) {
      rethrow;
    } catch (e) {
      throw CustomException('', 502, ExceptionType.CONNECTIONISSUE);
    }
  }
}

dynamic _response(http.Response response) {
  var data;
  try {
    data = json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    /// if response was string then it will come to this exception block
    data = utf8.decode(response.bodyBytes);
    return data;
  }

  var errorMessage = data?['Errors']?[0]?['code'] ??
      data?['Errors']?[0]?['message'] ??
      data?['Errors']?[0]?['description'] ??
      data?['error_description'] ??
      data?['error']?['fields']?[0]?['code'] ??
      data?['error']?['fields']?[0]?['message'];

  switch (response.statusCode) {
    case 200:
      return data;
    case 201:
      return data;
    case 400:
      throw CustomException(
          errorMessage, response.statusCode, ExceptionType.FETCHDATA);
      break;
    case 401:
    case 403:

      // if(currentRoute != Routes.LOGIN)
      //   navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);

      throw CustomException(
          errorMessage, response.statusCode, ExceptionType.UNAUTHORIZED);
      break;
    case 500:
      throw CustomException(
          errorMessage, response.statusCode, ExceptionType.INVALIDINPUT);
    default:
      throw CustomException(
          errorMessage, response.statusCode, ExceptionType.OTHER);
  }
}
