import 'package:flutter/material.dart';

class FooterBanner extends StatelessWidget {
  final String imageUrl;

  const FooterBanner({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image(
            width: 140,
            image: NetworkImage(
              imageUrl,
            )),
      ),
    );
  }
}
