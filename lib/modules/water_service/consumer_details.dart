import 'package:edge_client/models/consumer.dart';
import 'package:edge_client/modules/water_service/user_details.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/service/utils/model.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:edge_client/utils/global_variables.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:egov_widgets/widgets/BaseAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/consumer_provider.dart';
import '../../service/base_service.dart';
import '../../service/db/data_base.dart';

class ConsumerView extends StatefulWidget {
  final Map category;
  final UserDetails? consumer;
  const ConsumerView(this.category, {this.consumer, Key? key}) : super(key: key);

  @override
  _ConsumerViewState createState() => _ConsumerViewState();
}

class _ConsumerViewState extends State<ConsumerView> {
  @override
  Widget build(BuildContext context) {
    var isCreate = widget.category['categoryType'] == 'create';
    return Scaffold(
      appBar: BaseAppBar(
        Text(widget.category['categoryType']),
        AppBar(),
        const <Widget>[Icon(Icons.more_vert)],
      ),
      body: NetworkStatusBanner(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => ConsumerProvider(consumer: widget.consumer ?? UserDetails()),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Consumer<ConsumerProvider>(
                  builder : (_, provider, child) => Wrap(
                  spacing: 10,
                  children: [
                    BuildTextField(
                     "Name",
                      provider.consumer.nameCtrl
                    ),
                    BuildTextField(
                        "Father Name",
                        provider.consumer.fatherNameCtrl
                    ),
                    BuildTextField(
                        "Mobile Number",
                        provider.consumer.phoneCtrl
                    ),
                    BuildTextField(
                        "Email",
                        provider.consumer.emailCtrl
                    ),
                    BuildTextField(
                        "Street",
                        provider.consumer.streetCtrl
                    ),
                    BuildTextField(
                        "Pin Code",
                        provider.consumer.zipCodeCtrl
                    ),
                    ElevatedButton(onPressed: ()=> provider.createOrUpdateConsumer(context, isCreate: isCreate), child: Text(isCreate ? 'Create' : 'Update')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
