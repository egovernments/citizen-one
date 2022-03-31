import 'package:egov_widgets/localization/I18KeyConstants.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';

class HomeBack extends StatelessWidget {

  final Widget? widget;
  final VoidCallback? callback;

  const HomeBack({Key? key, this.widget, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: widget == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          children : [
            TextButton(
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.arrow_left,
                  color: Theme.of(context).primaryColorDark,
                ),
                Text(
                  ApplicationLocalizations.of(context).translate(i18.common.BACK),
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                )
              ],
            ),
            onPressed: callback ?? () =>  Navigator.pop(context)
          ),
            if(widget != null)
              widget!
          ]
        ));
  }
}
