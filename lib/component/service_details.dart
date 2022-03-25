
import 'package:edge_client/widgets/base_appbar.dart';
import 'package:flutter/material.dart';

import '../mixin/service_handler.dart';

class ServiceDetails extends StatefulWidget {
  final Map service;
  const ServiceDetails({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> with ServiceHandler{
  @override
  Widget build(BuildContext context) {
    var categoryList = getCategoriesBasedOnService(widget.service);
    return Scaffold(
      appBar: BaseAppBar(
         Text(widget.service['name']),
        AppBar(),
        const <Widget>[Icon(Icons.more_vert)],
      ),
      body:  ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final item = categoryList[index];
          return ListTile(
            onTap: () => categoryNavigator(widget.service['serviceType'], item, context),
            title: Text("${item['name']}"),
            subtitle: Text("${item['des']}"),
          );
        },
      ),
    );
  }
}
