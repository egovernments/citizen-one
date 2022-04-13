import 'package:flutter/material.dart';

class Loaders {
  static circularLoader({Color? color, double? height}) {
    return Container(
      height: height,
      color: color,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  static Future<void> showLoadingDialog(BuildContext context,
      {String? label}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SimpleDialog(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    children: <Widget>[
                      Center(
                        child: Column(children: [
                          // CircularLoader(
                          //   color: Theme.of(context).accentColor,
                          //   size: 30.0,
//                            controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                          // ),
                          CircularProgressIndicator(
                            color: Theme.of(context).accentColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            label ?? 'Loading...',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                      )
                    ]),
              ));
        });
  }

  static CircularLoader({Color? color}) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
