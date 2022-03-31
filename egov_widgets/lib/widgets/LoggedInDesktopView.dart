import 'package:flutter/material.dart';
import 'BackgroundContainer.dart';
import 'footer.dart';

class LoggedInDesktopView extends StatelessWidget {
  final Widget widget;
  final String footerImage;
  final String stateBannerUrl;

  const LoggedInDesktopView(this.widget, this.footerImage, this.stateBannerUrl);

  @override
  Widget build(BuildContext context) {
    return (BackgroundContainer(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Back(),
          (Center(
              child: Container(
                  width: 500,
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      padding: const EdgeInsets.all(8), child: widget)))),
          Footer(imageUrl: footerImage)
        ]), stateBannerUrl));
  }
}
