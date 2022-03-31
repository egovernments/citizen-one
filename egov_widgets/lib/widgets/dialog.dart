

import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  String title;
  String content;
  List<Map>? actions;
   CustomDialog({required this.title, required this.content,Key? key, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( '${ApplicationLocalizations.of(context).translate(title)}'),
      content: Text('${ApplicationLocalizations.of(context).translate(content)}'),
      actions: actions?.map((e) => TextButton(
        child: Text("${e['label']}"),
        onPressed: e['callBack'],
      )
    ).toList());
  }
}