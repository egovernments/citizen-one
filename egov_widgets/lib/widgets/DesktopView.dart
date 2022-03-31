import 'package:flutter/material.dart';
import 'BackgroundContainer.dart';
import 'footerBanner.dart';

class DesktopView extends StatelessWidget {
  final Widget widget;
  final String footerImage;
  final String stateBannerUrl;

  DesktopView(this.widget, this.footerImage, this.stateBannerUrl);

  @override
  Widget build(BuildContext context) {
    return (BackgroundContainer( Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 4),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    iconSize: 25,
                    color: Colors.white,
                    splashColor: Colors.purple,
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).maybePop()),
              )),
          (Center(
              child: new Container(
                  width: 500,
                  padding: EdgeInsets.all(15),
                  child: new Container(
                      padding: EdgeInsets.all(8), child: widget)))),
          FooterBanner(imageUrl: footerImage,)
        ]), stateBannerUrl));
  }
}
