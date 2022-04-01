import 'dart:async';
import 'dart:io';

import 'package:edge_client/screens/home.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      exit(1);
    };
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    exit(1);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        home: const SearchServices());
  }
}
