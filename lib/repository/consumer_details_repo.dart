import 'package:edge_client/models/bill/bill_payments.dart';
import 'package:edge_client/models/common/demand.dart';
import 'package:edge_client/models/common/fetch_bill.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/request_info.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:provider/provider.dart';

class ConsumerRepository extends BaseService {
  getReguestInfo(String criteria) {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    return RequestInfo(
        APIConstants.API_MODULE_NAME,
        APIConstants.API_VERSION,
        APIConstants.API_TS,
        criteria,
        APIConstants.API_DID,
        APIConstants.API_KEY,
        APIConstants.API_MESSAGE_ID,
        commonProvider.userDetails!.accessToken);
  }

  //Add Property API
  Future addProperty(Map body) async {
    var res = await makeRequest(
        url: ApiEndPoints.ADD_PROPERTY,
        body: {"Property": body},
        method: RequestType.POST,
        requestInfo: getReguestInfo('_create'));
    return res;
  }

  //Update Property API
  Future updateProperty(Map body) async {
    var res = await makeRequest(
        url: ApiEndPoints.UPDATE_PROPERTY,
        body: {"Property": body},
        method: RequestType.POST,
        requestInfo: getReguestInfo('_update'));
    return res;
  }

//Adding Water Connection
  Future addconnection(Map body) async {
    var res = await makeRequest(
        url: ApiEndPoints.ADD_WC_CONNECTION,
        body: {"WaterConnection": body},
        method: RequestType.POST,
        requestInfo: getReguestInfo('_create'));
    return res;
  }

  //Update Water Connection
  Future updateconnection(Map body) async {
    var res = await makeRequest(
        url: ApiEndPoints.UPDATE_WC_CONNECTION,
        body: {"WaterConnection": body},
        method: RequestType.POST,
        requestInfo: getReguestInfo('_update'));
    return res;
  }

//Fetching of Property
  Future getProperty(Map<String, dynamic> query) async {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    var body = {'userInfo': commonProvider.userDetails?.userRequest?.toJson()};

    var res = await makeRequest(
        url: ApiEndPoints.GET_PROPERTY,
        body: body,
        queryParameters: query,
        method: RequestType.POST,
        requestInfo: getReguestInfo('_search'));
    return res;
  }

  //Getting LocationDetails
  Future getLocations(Map body) async {
    var res = await makeRequest(
        url: ApiEndPoints.EGOV_LOCATIONS,
        queryParameters: body.map((key, value) =>
            MapEntry(key, value == null ? null : value.toString())),
        method: RequestType.POST,
        requestInfo: getReguestInfo('_search'));
    return res;
  }

  Future<List<FetchBill>?> getBillDetails(Map<String, dynamic> query) async {
    List<FetchBill>? fetchBill;
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var body = {'userInfo': commonProvider.userDetails?.userRequest?.toJson()};

    var res = await makeRequest(
        url: ApiEndPoints.FETCH_BILL,
        method: RequestType.POST,
        queryParameters: query,
        body: body,
        requestInfo: RequestInfo(
            APIConstants.API_MODULE_NAME,
            APIConstants.API_VERSION,
            APIConstants.API_TS,
            "",
            APIConstants.API_DID,
            APIConstants.API_KEY,
            APIConstants.API_MESSAGE_ID,
            commonProvider.userDetails!.accessToken));

    if (res != null) {
      fetchBill =
          res['Bill']?.map<FetchBill>((e) => FetchBill.fromJson(e)).toList();
    }
    return fetchBill;
  }

  Future<List<Demand>?> getDemandDetails(Map<String, dynamic> query) async {
    List<Demand>? demand;
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var body = {'userInfo': commonProvider.userDetails?.userRequest?.toJson()};

    var res = await makeRequest(
        url: ApiEndPoints.FETCH_DEMAND,
        method: RequestType.POST,
        body: body,
        queryParameters: query,
        requestInfo: RequestInfo(
            APIConstants.API_MODULE_NAME,
            APIConstants.API_VERSION,
            APIConstants.API_TS,
            "",
            APIConstants.API_DID,
            APIConstants.API_KEY,
            APIConstants.API_MESSAGE_ID,
            commonProvider.userDetails!.accessToken));

    if (res != null) {
      demand = res['Demands']?.map<Demand>((e) => Demand.fromJson(e)).toList();
    }
    return demand;
  }

  Future<BillPayments?> collectPayment(Map body) async {
    BillPayments? response;
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var res = await makeRequest(
        url: ApiEndPoints.COLLECT_PAYMENT,
        method: RequestType.POST,
        body: body,
        requestInfo: RequestInfo(
            APIConstants.API_MODULE_NAME,
            APIConstants.API_VERSION,
            APIConstants.API_TS,
            "",
            APIConstants.API_DID,
            APIConstants.API_KEY,
            APIConstants.API_MESSAGE_ID,
            commonProvider.userDetails!.accessToken));

    if (res != null) {
      response = BillPayments.fromJson(res);
    }
    return response;
  }
}
