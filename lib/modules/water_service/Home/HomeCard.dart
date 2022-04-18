import 'package:edge_client/providers/home_provider.dart';
import 'package:edge_client/providers/language.dart';
import 'package:edge_client/utils/role_actions.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/common_provider.dart';
import '../ConsumerDetails/ConsumerDetails.dart';

final String assetName = 'assets/svg/HHRegister.svg';

class HomeCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeCard();
  }
}

class _HomeCard extends State<HomeCard> {
  @override
  void initState() {
    super.initState();
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.getLocalizationData(context);
  }

  List<Widget> getList(HomeProvider homeProvider) {
    return RoleActionsFiltering().getFilteredModules().map((item) {
      return GridTile(
        child: GestureDetector(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) =>
               ConsumerDetails()
               ));
            },
            child: Card(
                key: homeProvider.homeWalkthrougList
                    .where((element) => element.label == item.label)
                    .first
                    .key,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(item.iconData, size: 35),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        ApplicationLocalizations.of(context)
                            .translate(item.label),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      )),
                    )
                  ],
                ))),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    var commonProvider = Provider.of<CommonProvider>(context, listen: false);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 760) {
        return Container(
            child: commonProvider.userDetails?.selectedtenant != null &&
                    commonProvider.userDetails?.userRequest != null
                ? (GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: .85,
                    children: getList(homeProvider),
                  ))
                : Text(""));
      } else {
        return Container(
            margin: EdgeInsets.only(left: 75, right: 75),
            child: commonProvider.userDetails?.selectedtenant != null &&
                    commonProvider.userDetails?.userRequest != null
                ? ( GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 3,
                    children: getList(homeProvider),
                  ))
                : Text(""));
      }
    });
  }
}
