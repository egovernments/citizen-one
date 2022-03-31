import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget widget;
  final String stateBannerUrl;

  BackgroundContainer(this.widget, this.stateBannerUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xff0B4B66),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: NetworkImage(stateBannerUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: widget);
  }
}
