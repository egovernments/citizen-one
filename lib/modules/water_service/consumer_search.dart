
import 'package:edge_client/modules/water_service/user_details.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/consumer_provider.dart';

class ConsumerSearch extends StatefulWidget {
  final Map category;

  const ConsumerSearch(this.category, {Key? key}) : super(key: key);

  @override
  _ConsumerSearchState createState() => _ConsumerSearchState();
}

class _ConsumerSearchState extends State<ConsumerSearch> {
  var searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        Text(widget.category['categoryType']),
        AppBar(),
        const <Widget>[Icon(Icons.more_vert)],
      ),
      body: ChangeNotifierProvider(
        create: (context) => ConsumerProvider(consumer: UserDetails()),
        child : Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Consumer<ConsumerProvider>(
            builder: (_, provider, child) => Wrap(
              children: [
                const Text('Search Consumers by Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
                ),
                BuildTextField(
                    "Consumer Name",
                    searchCtrl
                ),
                ElevatedButton(onPressed: () => provider.searchConsumer(searchCtrl.text.trim(), widget.category), child: Text('Search'))
              ],
            ),
          ),
        ),
      )
    );
  }
}
