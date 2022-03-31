import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final input;
  final EdgeInsets? padding;
  LabelText(this.input, {this.padding});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            child: Padding(
          padding: padding ?? (constraints.maxWidth > 760 ? const EdgeInsets.all(20.0) : const EdgeInsets.all(8.0)),
          child: Text(
            ApplicationLocalizations.of(context).translate(input),
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.left,
          ),
        )));
  });
  }
}
