
import 'package:egov_widgets/utils/color_codes.dart';
import 'package:flutter/material.dart';

mixin CommonStyles {

  static BoxDecoration get buttonBottomDecoration => const BoxDecoration(
      border: Border(bottom: BorderSide(color: ColorCodes.BUTTON_BOTTOM, width: 2))
  );

  static TextStyle get hintStyle => TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: ColorCodes.TEXT_HINT);
}