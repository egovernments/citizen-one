import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/mixin/common_styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget with CommonStyles{
  final String label;
  final Function()? widgetfunction;
  final Key? key;
  Button(this.label, this.widgetfunction, {this.key});

  @override
  Widget build(BuildContext context) {
    return new FractionallySizedBox(
        child: Container(
          decoration: CommonStyles.buttonBottomDecoration,
          child: new ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 30),
                  primary: widgetfunction == null ? Color.fromRGBO(244, 119, 56, 0.7) : null
                // padding: EdgeInsets.all(15),
              ),
              child: new Text(ApplicationLocalizations.of(context).translate(label),
                  style: Theme.of(context).textTheme.button),
              onPressed: () => widgetfunction != null ? widgetfunction!() : null
          ),
        ));
  }
}