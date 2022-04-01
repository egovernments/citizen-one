import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/widgets/Tost/toster.dart';
import 'package:flutter/material.dart';

class Notifiers {
  static getToastMessage(BuildContext context, String message, type) {
    ToastUtils.showCustomToast(
        context, ApplicationLocalizations.of(context).translate(message), type);
  }

  static Widget networkErrorPage(context, VoidCallback callBack) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Unable to connect to the server",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: callBack,
              child: Text(
                'Retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
