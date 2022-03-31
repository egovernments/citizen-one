import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/mixin/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomButtonBar extends StatelessWidget with CommonStyles{
  final String label;
  final Function()? callBack;
  final Key? key;
  BottomButtonBar(this.label, this.callBack, {this.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          height: constraints.maxWidth > 760 ? 60 : null,
          child: Card(
            elevation: 0.0,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 760) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          decoration: CommonStyles.buttonBottomDecoration,
                          margin: EdgeInsets.only(right: 20),
                          width: 300,
                          height: 60,
                          child: _buildButton(context)),
                    );
                  } else {
                    return Container(
                        decoration: CommonStyles.buttonBottomDecoration,
                        width: constraints.maxWidth,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: _buildButton(context));
                  }
                })),
          ));
    });
  }

  Widget _buildButton(context) {
    print(ApplicationLocalizations.of(context).translate(this.label));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: callBack == null ? Color.fromRGBO(244, 119, 56, 0.7) : null
      ),
      child: Text(
        ApplicationLocalizations.of(context).translate(this.label),
      ),
      onPressed: () => callBack != null ? callBack!() : null,
    );
  }
}
