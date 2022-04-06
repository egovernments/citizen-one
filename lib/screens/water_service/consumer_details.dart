
import 'package:egov_widgets/widgets/BaseAppBar.dart';
import 'package:flutter/material.dart';


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
      ],
    ),
    ),
    );
  }
}
