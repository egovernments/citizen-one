import 'dart:async';
import 'dart:io';

import 'package:edge_client/modules//home.dart';
import 'package:edge_client/modules/SelectLanguage/languageSelection.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/providers/consumer_details_provider.dart';
import 'package:edge_client/providers/home_provider.dart';
import 'package:edge_client/providers/tenants_provider.dart';
import 'package:edge_client/service/db/offline_api_handler.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:edge_client/utils/theme.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'environments/env.dart';
import 'providers/authentication.dart';
import 'providers/language.dart';
import 'service/interceptors.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // exit(1);
    };

    /// Initiating the interceptors for handling the offline
    initiateInterceptors();

    /// Pass default environment
    Environment().initConfig(Environment.getEnvironment(EnvType.dev));
    NetworkConnectivity.addConnectivityListener((OfflineApiHandler.sync));
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    // exit(1);
  });
}

class MyApp extends StatelessWidget {
  late Locale _locale = Locale('en', 'IN');
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => TenantsProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => ConsumerProvider()),
        ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: theme,
          supportedLocales: const [
            Locale('en', 'IN'),
            Locale('hi', 'IN'),
            Locale.fromSubtags(languageCode: 'pn')
          ],
          locale: _locale,
          localizationsDelegates: const [
            ApplicationLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocaleLanguage in supportedLocales) {
              if (supportedLocaleLanguage.languageCode ==
                  locale?.languageCode &&
                  supportedLocaleLanguage.countryCode ==
                      locale?.countryCode) {
                return supportedLocaleLanguage;
              }
            }
            return supportedLocales.first;
          },
          home:  const LandingPage()),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    Provider.of<CommonProvider>(context, listen: false)
        .getLoginCredentails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var commonProvider = Provider.of<CommonProvider>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
          stream: commonProvider.userLoggedStreamCtrl.stream,
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:

              /// While waiting for the data to load, show a loading spinner.
                return Loaders.circularLoader();
              default:
                if (snapshot.hasError) {
                  return Notifiers.networkErrorPage(context, () {});
                } else {
                  if (snapshot.data != null &&
                      commonProvider.userDetails!.isFirstTimeLogin == true) {
                    return const SearchServices();
                  }
                  return SelectLanguage();
                }
            }
          }),
    );
  }
}


