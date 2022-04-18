import 'package:edge_client/localization/I18KeyConstants.dart';
import 'package:edge_client/models/localization/language.dart';
import 'package:edge_client/modules/SelectLanguage/LanguageCard.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/widgets/BackgroundContainer.dart';
import 'package:egov_widgets/widgets/Button.dart';
import 'package:egov_widgets/widgets/footerBanner.dart';
import 'package:flutter/material.dart';

class LanguageSelectionDesktopView extends StatelessWidget {
  final StateInfo stateInfo;
  final Function changeLanguage;
  LanguageSelectionDesktopView(this.stateInfo, this.changeLanguage);

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: new Container(
                height: 300,
                width: 500,
                padding: EdgeInsets.all(15),
                child: Card(
                    child: (Column(children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              width: 150,
                              image: NetworkImage(
                                stateInfo.logoUrl!,
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" | ",
                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Color.fromRGBO(0,0,0,1)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(ApplicationLocalizations.of(context).translate(stateInfo.code!),
                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Color.fromRGBO(0,0,0,1)),
                                      textAlign: TextAlign.left,
                                    ),
                                  )))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (Languages language
                                in stateInfo.languages ?? [])
                              Row(
                                children: [
                                  stateInfo.languages!.first == language
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          margin: EdgeInsets.all(5),
                                          child: Text('${language.label}'))
                                      : Container(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left:
                                                      BorderSide(width: 1.0))),
                                          child: Text('${language.label}')),
                                ],
                              )
                          ])),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var language in stateInfo.languages ?? [])
                              LanguageCard(language, stateInfo.languages ?? [],
                                  120, 10, 10)
                          ])),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Button(i18.common.CONTINUE,
                          (){},
                         )),
                  SizedBox(
                    height: 10,
                  )
                ]))))),
        // FooterBanner()
      ],
    ), '');
  }
}
