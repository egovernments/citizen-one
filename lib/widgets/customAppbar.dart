import 'package:edge_client/models/mdms/tenants.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/providers/language.dart';
import 'package:edge_client/providers/tenants_provider.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar()
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super();
  @override
  final Size preferredSize; // default is 56.0
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with HelperMethods {
  Tenants? tenants;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => afterViewBuild());
    super.initState();
  }

  afterViewBuild() {
    var tenantProvider = Provider.of<TenantsProvider>(context, listen: false);

    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    if (tenantProvider.tenants != null) {
      final r = commonProvider.userDetails!.userRequest!.roles!
          .map((e) => e.tenantId)
          .toSet()
          .toList();
      final result = tenantProvider.tenants!.tenantsList
          ?.where((element) => r.contains(element.code?.trim()))
          .toList();
      if (result?.length == 1 &&
          commonProvider.userDetails!.selectedtenant == null) {
        if (result?.isNotEmpty ?? false)
          commonProvider.setTenant(result?.first);

        // });
      } else if (result != null &&
          result.length > 1 &&
          commonProvider.userDetails!.selectedtenant == null) {
        WidgetsBinding.instance
            ?.addPostFrameCallback((_) => showdialog(result));
      }
    } else {
      tenantProvider.getTenants().then((value) {
        final r = commonProvider.userDetails!.userRequest!.roles!
            .map((e) => e.tenantId)
            .toSet()
            .toList();
        final result = tenantProvider.tenants!.tenantsList
            ?.where((element) => r.contains(element.code?.trim()))
            .toList();
        if (result?.length == 1 &&
            commonProvider.userDetails!.selectedtenant == null) {
          if (result?.isNotEmpty ?? false)
            commonProvider.setTenant(result?.first);

          // });
        } else if (result != null &&
            result.length > 1 &&
            commonProvider.userDetails!.selectedtenant == null) {
          WidgetsBinding.instance
              ?.addPostFrameCallback((_) => showdialog(result));
        }
      });
    }
  }

  showdialog(result) {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    var tenantProvider = Provider.of<TenantsProvider>(context, listen: false);
    final r = commonProvider.userDetails!.userRequest!.roles!
        .map((e) => e.tenantId)
        .toSet()
        .toList();
    final res = tenantProvider.tenants!.tenantsList!
        .where((element) => r.contains(element.code?.trim()))
        .toList();
    showDialog(
        barrierDismissible: commonProvider.userDetails!.selectedtenant != null,
        context: context,
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width > 720
                        ? MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 3
                        : 0,
                    top: 60),
                width: MediaQuery.of(context).size.width > 720
                    ? MediaQuery.of(context).size.width / 3
                    : MediaQuery.of(context).size.width,
                height: res.length * 50 < 300 ?
                res.length * 50 : 300,
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: List.generate(result.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          commonProvider.setTenant(result[index]);
                          Navigator.pop(context);
                          home();
                        },
                        child: Material(
                            child: Container(
                          color: index.isEven
                              ? Colors.white
                              : Color.fromRGBO(238, 238, 238, 1),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ApplicationLocalizations.of(context)
                                        .translate(result[index].code!),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: commonProvider.userDetails!
                                                        .selectedtenant !=
                                                    null &&
                                                commonProvider
                                                        .userDetails!
                                                        .selectedtenant!
                                                        .city!
                                                        .code ==
                                                    result[index].city!.code!
                                            ? Theme.of(context).primaryColor
                                            : Colors.black),
                                  ),
                                  Text(result[index].city!.code!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: commonProvider.userDetails!
                                                          .selectedtenant !=
                                                      null &&
                                                  commonProvider
                                                          .userDetails!
                                                          .selectedtenant!
                                                          .city!
                                                          .code ==
                                                      result[index].city!.code!
                                              ? Theme.of(context).primaryColor
                                              : Colors.black))
                                ]),
                          ),
                        )));
                  }),
                ))
          ]);
        });
  }

  buildtenantsView(Tenant tenant) {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    final r = commonProvider.userDetails!.userRequest!.roles!
        .map((e) => e.tenantId)
        .toSet()
        .toList();
    final result = tenant.tenantsList!
        .where((element) => r.contains(element.code?.trim()))
        .toList();
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<CommonProvider>(
                  builder: (_, commonProvider, child) =>
                      commonProvider.userDetails?.selectedtenant == null
                          ? Text("")
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                  Text(ApplicationLocalizations.of(context)
                                      .translate(commonProvider
                                          .userDetails!.selectedtenant!.code!)),
                                  Text(ApplicationLocalizations.of(context)
                                      .translate(commonProvider.userDetails!
                                          .selectedtenant!.city!.code!))
                                ])),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        onTap: () => showdialog(result));
  }

  @override
  Widget build(BuildContext context) {
    var tenantProvider = Provider.of<TenantsProvider>(context, listen: false);
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return AppBar(
      titleSpacing: 0,
      title: Image(
          width: 130,
          image: NetworkImage(
            languageProvider.stateInfo!.logoUrlWhite!,
          )),
      actions: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  tenantProvider.tenants != null
                      ? buildtenantsView(tenantProvider.tenants!)
                      : StreamBuilder(
                          stream: tenantProvider.streamController.stream,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return buildtenantsView(snapshot.data);
                            } else if (snapshot.hasError) {
                              return Notifiers.networkErrorPage(context, () {});
                            } else {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Loaders.CircularLoader();
                                case ConnectionState.active:
                                  return Loaders.CircularLoader();
                                default:
                                  return Container(
                                    child: Text(""),
                                  );
                              }
                            }
                          })
                ]))
      ],
    );
  }
}
