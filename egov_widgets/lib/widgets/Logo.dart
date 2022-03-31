import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String logoUrl;
  final String stateLabel;

  const Logo({Key? key, required this.logoUrl, required this.stateLabel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Center(
                  child: Image(
                      width: 150,
                      image: NetworkImage(
                        logoUrl,
                      )),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 15), child: Text(" | ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Color.fromRGBO(0,0,0,1)),)),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ApplicationLocalizations.of(context).translate(stateLabel),
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Color.fromRGBO(0,0,0,1)),
                        textAlign: TextAlign.left,
                      ),
                    )))
          ],
        )));
  }
}
