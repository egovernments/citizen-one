import 'package:edge_client/component/search_result.dart';
import 'package:edge_client/component/service_details.dart';
import 'package:edge_client/modules/water_service/Home/Home.dart';
import 'package:edge_client/service/db/offline_api_handler.dart';
import 'package:edge_client/widgets/SideBar.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/widgets/BaseAppBar.dart';
import 'package:egov_widgets/widgets/DrawerWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';


class SearchServices extends StatefulWidget {
  const SearchServices({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchServicesState();
  }
}

class _SearchServicesState extends State<SearchServices> {
  ValueNotifier<String> pattern = ValueNotifier<String>('');
  var serviceList = [
    {
      "name" : "Water",
      "des" : "You can create, update and collect payment for water connections",
      "serviceType" : "water",
    },
    {
      "name" : "Property Tax",
      "des" : "You can apply for a new property, update and search for it",
      "serviceType" : "propertyTax",
    },
    {
      "name" : "Trade Licence",
      "des" : "You can apply, renew and search for Trade licences",
      "serviceType" : "tradeLicence",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: const Text('Citizen-One'),
          actions:
            const <Widget>[IconButton(onPressed: OfflineApiHandler.sync, icon: Icon(Icons.sync))]
        ),
        drawer: DrawerWrapper(
          Drawer(child: SideBar()),
        ),
        body: NetworkStatusBanner(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                          onChanged: (text) {
                            pattern.value = text.trim();
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Search for services',
                          )),
                      Expanded(
                          child: ValueListenableBuilder<String>(valueListenable: pattern, builder: (contex, value, child) => SearchResult(
                            data: serviceList,
                            pattern: pattern.value,
                            callBack: (val) => Navigator.push(context, MaterialPageRoute(builder: (_) => val['serviceType'] == 'water' ? const Home() : ServiceDetails(service: val))),
                          ))),
                    ],
                  ),
                ),
              ));
  }
}
