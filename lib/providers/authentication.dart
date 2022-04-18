import 'dart:io';

import 'package:edge_client/modules/home.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/repository/authentication.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language.dart';

class AuthenticationProvider with ChangeNotifier {
  validateLogin(BuildContext context, String userName, String password) async {
    /// Unfocus the text field
    FocusScope.of(context).unfocus();

    try {
      var languageProvider = Provider.of<LanguageProvider>(
          navigatorKey.currentContext!,
          listen: false);
      var body = {
        "username": userName,
        "password": password,
        "scope": "read",
        "grant_type": "password",
        "tenantId": languageProvider.stateInfo!.code,
        "userType": "EMPLOYEE"
      };

      var headers = {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        "Access-Control-Allow-Origin": "*",
        "authorization": "Basic ZWdvdi11c2VyLWNsaWVudDo=",
      };

      Loaders.showLoadingDialog(context);

      var loginResponse =
          await AuthenticationRepository().validateLogin(body, headers);

      if (loginResponse != null) {
        var userInfo = await AuthenticationRepository().getProfile({
          "tenantId": loginResponse.userRequest!.tenantId,
          "id": [loginResponse.userRequest!.id],
          "mobileNumber": loginResponse.userRequest!.mobileNumber
        }, loginResponse.accessToken!);
        var commonProvider = Provider.of<CommonProvider>(context, listen: false);
        loginResponse.isFirstTimeLogin = userInfo.user!.first.defaultPwdChgd;
        commonProvider.loginCredentails = loginResponse;
        Navigator.pop(context);

        // if (userInfo.user!.first.defaultPwdChgd == false) {
        //   commonProvider.userProfile = userInfo;
          // Navigator.pushNamed(context, Routes.UPDATE_PASSWORD,
          //     arguments: loginResponse);
        //   return;
        // } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const SearchServices()), (Route<dynamic> route) => false);
        // }
      }
    }  catch (e, s) {
      Navigator.pop(context);
      // ErrorHandler.logError(e.toString(), s);
      Notifiers.getToastMessage(context, e.toString(), 'ERROR');
    }
  }

  void callNotifyer() {
    notifyListeners();
  }
}
