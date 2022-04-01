import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../localization/application_localizations.dart';

class PdfUtils {

  static pw.Widget buildAppBar(BuildContext context, pw.ImageProvider image, pw.Font icons, pw.Font font) {

    var style = pw.TextStyle(fontSize: 14, font: font, color: PdfColor.fromHex('#FFFFFF'));

    return pw.Container(
        padding: pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: pw.EdgeInsets.only(bottom: 5),
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('#0B4B66')),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Wrap(
                  crossAxisAlignment: pw.WrapCrossAlignment.center,
                  children : [
                    pw.SizedBox(width: 2),
                    pw.Image(image,
                        width: 90),
                  ]),
              pw.Wrap(
                spacing: 3,
                children: [
                  pw.Text(
                      ApplicationLocalizations.of(context).translate('Add required Text'),
                      style: style),
                ],
              )
            ]));
  }

  static Future<pw.ImageProvider> get appLogo async {
    return await networkImage('Add App Logo here');
  }

  static Future<pw.ImageProvider> get footerImage async => await networkImage("Add Footer Image URL here");

  static pw.Widget pdfFooter(pw.ImageProvider image){
    return pw.Container(
        margin: pw.EdgeInsets.only(top: 10),
        alignment: pw.Alignment.center,
        child: pw.SizedBox(
            width: 100,
            child: pw.Image(image)
        )
    );

  }
}