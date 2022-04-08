import 'dart:async';
import 'dart:io';

import 'package:edge_client/modules//home.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:edge_client/utils/theme.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'environments/env.dart';
import 'service/db/data_base.dart';
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
    Environment().initConfig(Environment.getEnvironment(EnvType.qa));
    DataBase.initiateDataBase();
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
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: theme,
        supportedLocales: [
          Locale('en', 'IN'),
          Locale('hi', 'IN'),
          Locale.fromSubtags(languageCode: 'pn')
        ],
        locale: _locale,
        localizationsDelegates: [
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
        home: const SearchServices());
  }
}
