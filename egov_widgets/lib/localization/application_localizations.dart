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

  static List<LocalizationLabel> _localizedStrings = <LocalizationLabel>[];

  Future<bool> load(Function? callBack) async {
    if(callBack == null) return true;
    _localizedStrings = await callBack();
    return true;
  }

  // called from every widget which needs a localized text
  translate(String label) {
    var index = _localizedStrings
        .indexWhere((medium) => medium.code == label);
    return index != -1
        ? _localizedStrings[index].message
        : label;
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
  Future<ApplicationLocalizations> load(Locale locale, ) async {
    ApplicationLocalizations localization =
         ApplicationLocalizations(locale);
    await localization.load(null);
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<ApplicationLocalizations> old) =>
      false;
}
