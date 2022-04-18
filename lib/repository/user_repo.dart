
import 'package:edge_client/modules/water_service/user_details.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:egov_widgets/utils/models.dart';

import '../service/utils/api_end_points.dart';
import '../utils/enums.dart';

class UserRepository extends BaseService {

  Future<dynamic> consumerCreateOrUpdate(dynamic body) async {
      var response = await makeRequest(
          url: ApiEndPoints.consumer,
          body: body,
          headers: {
            'serviceType': ServiceType.waterService
                .toString()
                .split('.')
                .last
          },
          method: RequestType.POST);
      return response;
  }

  Future<List<UserDetails>> searchForConsumer(Map<String, dynamic> query) async {
    var consumerList = <UserDetails>[];
    var response = await makeRequest(
        url: ApiEndPoints.consumer,
        queryParameters: query,
        headers: {
          'serviceType': ServiceType.waterService
              .toString()
              .split('.')
              .last
        },
        method: RequestType.GET);

    if(response != null && response is List){
      consumerList = response.map<UserDetails>((e) => UserDetails.fromJson(e)).toList();
    }
    return consumerList;
  }
}