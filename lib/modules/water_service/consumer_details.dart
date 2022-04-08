
import 'package:edge_client/models/consumer.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/model.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:edge_client/utils/global_variables.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:egov_widgets/widgets/BaseAppBar.dart';
import 'package:flutter/material.dart';

import '../../service/base_service.dart';
import '../../service/db/data_base.dart';


class Consumer extends StatefulWidget {
  final Map category;
  const Consumer(this.category, {Key? key}) : super(key: key);

  @override
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<Consumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        Text(widget.category['categoryType']),
        AppBar(),
        const <Widget>[Icon(Icons.more_vert)],
      ),
          body: Container(
            padding: EdgeInsets.all(10),
        child: Wrap(
    spacing: 10,
        children: [
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          ElevatedButton(onPressed: () async{
            try {
              var data = await BaseService().makeRequest(
                  url: ApiEndPoints.consumer,
                  headers: {
                    'serviceType' : ServiceType.waterService.toString().split('.').last
                  },
                  method: RequestType.GET);
              print(data);
            }catch(e){
              print(e);
            }
          }, child: Text(('elevated btn'))),
          ElevatedButton(onPressed: () async{
            try {
              var consumer = ConsumerDetails(
                  // id: 0,
                  connectionType: 'residentail',
                  consumerName: 'krishna ji',
                  fatherName: 'ramesh',
                  mobileNumber: 9949210191,
                  serviceTYpe: 'meter');

              var data = await BaseService().makeRequest(
                  url: ApiEndPoints.consumer,
                  body: consumer.toJson(),
                  headers: {
                    'serviceType' : ServiceType.waterService.toString().split('.').last
                  },
                  method: RequestType.POST);
              print(data);
            }catch(e){
              print(e);
            }
          }, child: Text(('elevated btn')))

      ],
    ),
    ),
    );
  }
}
