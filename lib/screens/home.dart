import 'package:edge_client/component/search_result.dart';
import 'package:edge_client/widgets/base_appbar.dart';
import 'package:flutter/material.dart';

import '../component/service_details.dart';

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
        appBar: BaseAppBar(
          const Text("EDGE"),
          AppBar(),
          const <Widget>[Icon(Icons.more_vert)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      callBack: (val) => Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceDetails(service: val))),
                    ))),
              ]),
        ));
  }
}
