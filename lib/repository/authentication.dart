

import 'package:edge_client/models/user/user_details.dart';
import 'package:edge_client/models/user/user_profile.dart';
// import 'package:edge_client/modules/water_service/user_details.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/request_info.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';

import '../service/base_service.dart';

class AuthenticationRepository extends BaseService {
  Future<UserDetails> validateLogin(
      Map body, Map<String, String> headers) async {
    late UserDetails loginResponse;

    var res = await makeRequest(
        url: UserUrl.AUTHENTICATE,
        body: body,
        headers: headers,
        method: RequestType.POST);
    if (res != null) {
      loginResponse = UserDetails.fromJson(res);
    }
    return loginResponse;
  }

  Future<UserProfile> getProfile(Map body, String token) async {
    final requestInfo = RequestInfo(
        APIConstants.API_MODULE_NAME,
        APIConstants.API_VERSION,
        APIConstants.API_TS,
        "POST",
        APIConstants.API_DID,
        APIConstants.API_KEY,
        APIConstants.API_MESSAGE_ID,
        token);
    late UserProfile userProfile;
    var res = await makeRequest(
        url: UserUrl.USER_PROFILE,
        body: body,
        requestInfo: requestInfo,
        method: RequestType.POST);
    if (res != null) {
      userProfile = UserProfile.fromJson(res);
      userProfile.user![0].setText();
    }
    return userProfile;
  }
}
