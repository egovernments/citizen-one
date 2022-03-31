import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/mixin/common_styles.dart';
import 'package:flutter/material.dart';

class ShortButton extends StatelessWidget with CommonStyles{
  final String label;
  final VoidCallback? callBack;
  final Key? key;
  ShortButton(this.label, this.callBack,{this.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 48,
        width: constraints.maxWidth > 760 ? constraints.maxWidth / 4 : constraints.maxWidth,
            decoration: CommonStyles.buttonBottomDecoration,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13)
              ),
              key: key,
              child: Text(
                  ApplicationLocalizations.of(context).translate(label),
                   style:
                   Theme.of(context).textTheme.subtitle1!.apply(color: Colors.white)
            ),
              onPressed: callBack
            ),
          );
    });
  }
}
