import 'package:flutter/material.dart';
import 'customAppbar.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar(this.title, this.appBar, this.widgets);

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: widgets);
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
