import 'package:edge_client/models/mdms/tenants.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/request_info.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:egov_widgets/utils/global_variables.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:provider/provider.dart';

class TenantRepo extends BaseService {
  Future<Tenant> fetchTenants(Map body, [String? token]) async {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    late Tenant tenant;
    final requestInfo = RequestInfo('mGramSeva', .01, "", "search", "", "", "",
       token ?? commonProvider.userDetails!.accessToken);
    var res = await makeRequest(
        url: ApiEndPoints.MDMS,
        body: body,
        storeResponseInDb: true,
        headers: {
          'serviceType': ServiceType.coreService
              .toString()
              .split('.')
              .last
        },
        requestInfo: requestInfo,
        method: RequestType.POST);
    if (res != null) {
      tenant = Tenant.fromJson(res['MdmsRes']['tenant']);
    }
    return tenant;
  }
}
