import 'dart:async';

import 'package:edge_client/models/mdms/tenants.dart';
import 'package:edge_client/providers/tendants_repo.dart';
import 'package:edge_client/service/utils/MDMS.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common_provider.dart';

class TenantsProvider with ChangeNotifier {
  Tenant? tenants;
  var streamController = StreamController.broadcast();

  dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> getTenants() async {
    try {
      var commonProvider = Provider.of<CommonProvider>(
          navigatorKey.currentContext!,
          listen: false);
      var userResponse = await TenantRepo().fetchTenants(getTenantsMDMS(commonProvider.userDetails!.userRequest!.tenantId.toString()));
      if (userResponse != null) {
        tenants = userResponse;
        streamController.add(userResponse);
      }
    } catch (e, s) {
      // ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e, s);
      streamController.addError('error');
    }
  }

  void callNotifyer() {
    notifyListeners();
  }

  getTenant() {
    return tenants!.tenantsList!.length;
  }
}
