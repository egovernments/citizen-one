
import 'package:edge_client/modules/property_tax/user_details.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:edge_client/service/utils/base_urls.dart';
import 'package:egov_widgets/utils/models.dart';

import '../service/utils/api_end_points.dart';
import '../utils/enums.dart';

class UserRepository extends BaseService {

  Future<dynamic> consumerCreateOrUpdate(dynamic body) async {
      var response = await makeRequest(
          url: ApiEndPoints.propertyTax,
          baseUrl: BaseUrls.qualityAssurance,
          body: body,
          headers: {
            'serviceType': ServiceType.propertyService
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
        baseUrl: BaseUrls.qualityAssurance,
        url: ApiEndPoints.propertyTax,
        queryParameters: query,
        headers: {
          'serviceType': ServiceType.propertyService
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