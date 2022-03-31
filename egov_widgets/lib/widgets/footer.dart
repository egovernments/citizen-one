import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final EdgeInsets? padding;
  final String imageUrl;

  Footer({this.padding, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(25),
      child: Image(
          width: 140,
          image: NetworkImage(
            imageUrl,
          )),
    );
  }
}
