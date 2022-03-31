import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';
import 'common_styles.dart';

mixin CommonWidgets {

  Widget buildHint(String? label, BuildContext context) {
    return Visibility(
        visible: label != null,
        child: Container(
             padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text('${ApplicationLocalizations.of(context).translate(label ?? '')}', style: CommonStyles.hintStyle)));
  }

  static Widget buildEmptyMessage(String label, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('${ApplicationLocalizations.of(context).translate(label)}', style: Theme.of(context).textTheme.subtitle1),
    );
  }
}