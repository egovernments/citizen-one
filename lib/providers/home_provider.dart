import 'dart:async';
import 'package:edge_client/utils/role_actions.dart';
import 'package:flutter/material.dart';

import '../modules/water_service/Home/HomeWalkThrough/HomeWalkThroughList.dart';

class HomeProvider with ChangeNotifier {
  var streamController = StreamController.broadcast();
  late List<HomeWalkWidgets> homeWalkthrougList;
  int activeindex = 0;

  void setwalkthrough(value) {
    homeWalkthrougList = value
        .where((element) => RoleActionsFiltering()
            .getFilteredModules()
            .where((ele) => ele.label == element.label)
            .isNotEmpty)
        .toList();
  }

  incrementindex(index, homeKey) async {
    activeindex = index + 1;
    await Scrollable.ensureVisible(homeKey.currentContext!,
        duration: new Duration(milliseconds: 100));
  }

  dispose() {
    streamController.close();
    super.dispose();
  }

  void updateWalkThrough(value) {
    homeWalkthrougList = value;
  }
}
