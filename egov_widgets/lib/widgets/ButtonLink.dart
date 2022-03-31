import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';

class ButtonLink extends StatelessWidget {
  final String label;
  final Function()? widgetfunction;
  ButtonLink(this.label, this.widgetfunction);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widgetfunction,
      child: Padding(
          padding: const EdgeInsets.only(
              left: 8, top: 10, bottom: 10, right: 25),
          child: new Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ApplicationLocalizations.of(context)
                    .translate(label),
                style: TextStyle(
                    color: Theme.of(context).primaryColor),
              ))),
    );
  }
}
