import 'dart:async';
import 'dart:convert';
import 'package:egov_widgets/models/localization/localization_label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApplicationLocalizations {
  ApplicationLocalizations(this.locale);

  final Locale? locale;

  static ApplicationLocalizations of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(
        context, ApplicationLocalizations)!;
  }

  List<LocalizationLabel> _localizedStrings = <LocalizationLabel>[];

  Future<bool> load() async {
    // if (navigatorKey.currentContext == null) return false;
    // var commonProvider = Provider.of<CommonProvider>(
    //     navigatorKey.currentContext!,
    //     listen: false);
    // _localizedStrings = await commonProvider.getLocalizationLabels();
    return true;
  }

  // called from every widget which needs a localized text
  translate(String _localizedValues) {
    // var commonProvider = Provider.of<CommonProvider>(
    //     navigatorKey.currentContext!,
    //     listen: false);

    // var index = commonProvider.localizedStrings
    //     .indexWhere((medium) => medium.code == _localizedValues);
    // return index != -1
    //     ? commonProvider.localizedStrings[index].message
    //     : _localizedValues;
    return _localizedValues;
  }

  static const LocalizationsDelegate<ApplicationLocalizations> delegate =
      _ApplicationLocalizationsDelegate();
}

class _ApplicationLocalizationsDelegate
    extends LocalizationsDelegate<ApplicationLocalizations> {
  const _ApplicationLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pn', 'ar', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<ApplicationLocalizations> load(Locale locale) async {
    ApplicationLocalizations localization =
        new ApplicationLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<ApplicationLocalizations> old) =>
      false;
}
