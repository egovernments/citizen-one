import 'package:edge_client/environments/env.dart';
import 'package:edge_client/modules/water_service/Home/HomeCard.dart';
import 'package:edge_client/providers/language.dart';
import 'package:edge_client/providers/tenants_provider.dart';
import 'package:edge_client/utils/constants.dart';
import 'package:edge_client/widgets/customAppbar.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/widgets/DrawerWrapper.dart';
import 'package:egov_widgets/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/common_provider.dart';
import '../../../providers/home_provider.dart';
import 'HomeWalkThrough/HomeWalkThroughContainer.dart';
import 'HomeWalkThrough/HomeWalkThroughList.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => afterViewBuild());
    super.initState();
  }

  afterViewBuild() {
    Provider.of<TenantsProvider>(context, listen: false)..getTenants();
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    languageProvider.getLocalizationData(context);
  }

  _buildView(homeProvider, Widget Notid) {
    return Column(children: [
      // Align(
      //     alignment: Alignment.centerRight,
      //     child: Help(
      //       callBack: () => showGeneralDialog(
      //         barrierLabel: "Label",
      //         barrierDismissible: false,
      //         barrierColor: Colors.black.withOpacity(0.5),
      //         transitionDuration: Duration(milliseconds: 700),
      //         context: context,
      //         pageBuilder: (context, anim1, anim2) {
      //           return HomeWalkThroughContainer((index) =>
      //               homeProvider.incrementindex(
      //                   index, homeProvider.homeWalkthrougList[index + 1].key));
      //         },
      //         transitionBuilder: (context, anim1, anim2, child) {
      //           return SlideTransition(
      //             position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
      //                 .animate(anim1),
      //             child: child,
      //           );
      //         },
      //       ),
      //       walkThroughKey: Constants.HOME_KEY,
      //     )),
      HomeCard(),
      Notid,
      Footer(imageUrl: '${Environment().config?.apiHost}${Constants.DIGIT_FOOTER_WHITE_ENDPOINT}')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var tenantProvider = Provider.of<TenantsProvider>(context, listen: false);
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(),
        // drawer: DrawerWrapper(
        //   Drawer(child: SideBar()),
        // ),
        body: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraint) {
          return Consumer<CommonProvider>(
              builder: (_, commonProvider, child) => tenantProvider.tenants !=
                      null
                  ? Consumer<CommonProvider>(builder: (_, userProvider, child) {
                      Provider.of<HomeProvider>(context, listen: false)
                        ..setwalkthrough(
                            HomeWalkThrough().homeWalkThrough.map((e) {
                          e.key = GlobalKey();
                          return e;
                        }).toList());
                      return _buildHome(constraint);
                    })
                  : StreamBuilder(
                      stream: tenantProvider.streamController.stream,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Consumer<CommonProvider>(
                              builder: (_, userProvider, child) {
                            Provider.of<HomeProvider>(context, listen: false)
                              ..setwalkthrough(
                                  HomeWalkThrough().homeWalkThrough.map((e) {
                                e.key = GlobalKey();
                                return e;
                              }).toList());
                            return _buildHome(constraint);
                          });
                        } else if (snapshot.hasError) {
                          return Notifiers.networkErrorPage(
                              context,
                              () => languageProvider
                                  .getLocalizationData(context));
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Loaders.CircularLoader();
                            case ConnectionState.active:
                              return Loaders.CircularLoader();
                            default:
                              return Container();
                          }
                        }
                      }));
        })));
  }

  Widget _buildHome(BoxConstraints constraint) {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return _buildView(
      homeProvider,
      Container(
          margin: constraint.maxWidth < 720
              ? EdgeInsets.all(0)
              : EdgeInsets.only(left: 75, right: 75),

          // child: Consumer<CommonProvider>(builder: (_, userProvider, child) {
          //   if (userProvider.userDetails?.selectedtenant?.code != null) {
          //     var commonProvider =
          //         Provider.of<CommonProvider>(context, listen: false);
          //     try {
          //       Provider.of<NotificationProvider>(context, listen: false)
          //         ..getNotiications({
          //           "tenantId": userProvider.userDetails?.selectedtenant?.code!,
          //           "eventType": "SYSTEMGENERATED",
          //           "recepients": commonProvider.userDetails?.userRequest?.uuid,
          //           "limit": "50"
          //         }, {
          //           "tenantId": userProvider.userDetails?.selectedtenant?.code!,
          //           "eventType": "SYSTEMGENERATED",
          //           "roles": commonProvider.userDetails?.userRequest?.roles!
          //               .map((e) => e.code.toString())
          //               .join(',')
          //               .toString(),
          //           "limit": "50"
          //         });
          //     }
          //     catch (e, s) {
          //       ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e);
          //     }
          //   }
          //   return userProvider.userDetails?.selectedtenant?.code != null
          //       ?
          //         NotificationsList(close: true,)
          //       : Text("");
          // })),
    ));
  }
}