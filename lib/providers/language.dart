import 'dart:async';
import 'dart:convert';
import 'package:edge_client/models/localization/language.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/repository/core_repo.dart';
import 'package:edge_client/service/utils/MDMS.dart';
import 'package:edge_client/utils/constants.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

import '../utils/global_variables.dart';


class LanguageProvider with ChangeNotifier {
  var streamController = StreamController.broadcast();
  var userLoggedStreamCtrl = StreamController.broadcast();
  StateInfo? stateInfo;

  dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> getLocalizationData(BuildContext context) async {
    var commonProvider = Provider.of<CommonProvider>(
        context,
        listen: false);

    try {
      var res = await getLanguages();
      if (res != null) {
        stateInfo ??= res;
        setSelectedState(res);
        await ApplicationLocalizations(
                Locale(selectedLanguage?.label ?? '', selectedLanguage?.value))
            .load(commonProvider.getLocalizationLabels);
        var stateInfos = <StateInfo>[];
        stateInfos.add(StateInfo.fromJson(res.toJson()));
        streamController.add(stateInfos);
      } else {
        var localizationList =
            await CoreRepository().getMdms(initRequestBody({"tenantId": "pb"}));
        stateInfo = localizationList.mdmsRes?.commonMasters?.stateInfo?.first;
        if (stateInfo != null) {
          stateInfo?.languages?.first.isSelected = true;
          setSelectedState(stateInfo!);
          await ApplicationLocalizations(Locale(
                  selectedLanguage?.label ?? '', selectedLanguage?.value))
              .load(commonProvider.getLocalizationLabels);
        }
        streamController.add(
            localizationList.mdmsRes?.commonMasters?.stateInfo ??
                <StateInfo>[]);
      }
    } catch (e, s) {
      // ErrorHandler.logError(e.toString(), s);
      streamController.addError('error');
    }
  }

  void onSelectionOfLanguage(
      Languages language, List<Languages> languages) async {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

    if (language.isSelected) return;
    languages.forEach((element) => element.isSelected = false);
    language.isSelected = true;
    languages[languages.indexOf(language)] = language;
    stateInfo!.languages = languages;

    setSelectedState(stateInfo!);
    await ApplicationLocalizations(
            Locale(selectedLanguage?.label ?? '', selectedLanguage?.value))
        .load(commonProvider.getLocalizationLabels);
    notifyListeners();
  }

  void setSelectedState(StateInfo stateInfo) {
    if (kIsWeb) {
      window.localStorage[Constants.STATES_KEY] =
          jsonEncode(stateInfo.toJson());
    } else {
      storage.write(
          key: Constants.STATES_KEY, value: jsonEncode(stateInfo.toJson()));
    }
  }

  Future<StateInfo?> getLanguages() async {
    var userReposne;
    try {
      if (kIsWeb) {
        userReposne = window.localStorage[Constants.STATES_KEY];
      } else {
        userReposne = await storage.read(key: Constants.STATES_KEY);
      }
    } catch (e) {
      userLoggedStreamCtrl.add(null);
    }

    return userReposne != null
        ? StateInfo.fromJson(jsonDecode(userReposne))
        : null;
  }

  Languages? get selectedLanguage =>
      stateInfo?.languages?.firstWhere((element) => element.isSelected);
}
