import 'package:edge_client/models/connection/water_connections.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/request_info.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:provider/provider.dart';

class SearchConnectionRepository extends BaseService {
  late WaterConnections waterConnections;
  Future<WaterConnections> getconnection(Map<String, dynamic> query) async {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var body = {commonProvider.userDetails?.userRequest?.toJson()};
    final requestInfo = RequestInfo(
      APIConstants.API_MODULE_NAME,
      APIConstants.API_VERSION,
      APIConstants.API_TS,
      "_search",
      APIConstants.API_DID,
      APIConstants.API_KEY,
      APIConstants.API_MESSAGE_ID,
      commonProvider.userDetails!.accessToken,
      commonProvider.userDetails?.userRequest?.toJson(),
    );
    var res = await makeRequest(
        url: ApiEndPoints.FETCH_WC_CONNECTION,
        queryParameters: query,
        method: RequestType.POST,
        body: {},
        requestInfo: requestInfo);

    if (res != null) {
      waterConnections = WaterConnections.fromJson(res);
    }
    return waterConnections;
  }

  // Future<WaterConnections> getConnectionName(Map<String, dynamic> query) async {
  //   var commonProvider = Provider.of<CommonProvider>(
  //       navigatorKey.currentContext!,
  //       listen: false);
  //
  //   final requestInfo = RequestInfo(
  //     APIConstants.API_MODULE_NAME,
  //     APIConstants.API_VERSION,
  //     APIConstants.API_TS,
  //     "_search",
  //     APIConstants.API_DID,
  //     APIConstants.API_KEY,
  //     APIConstants.API_MESSAGE_ID,
  //     commonProvider.userDetails!.accessToken,
  //     commonProvider.userDetails?.userRequest?.toJson(),
  //   );
  //   var res = await makeRequest(
  //       url: Url.FETCH_CONNECTION_NAME,
  //       queryParameters: query,
  //       method: RequestType.POST,
  //       body: {},
  //       requestInfo: requestInfo);
  //
  //   if (res != null) {
  //     waterConnections = WaterConnections.fromJson(res);
  //   }
  //   return waterConnections;
  // }
}
