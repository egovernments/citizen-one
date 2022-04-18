import 'dart:typed_data';

import 'package:flutter/material.dart';

class HomeItem {
  final String label;
  final String walkThroughMsg;
  final IconData iconData;
  final String link;
  final Map<String, dynamic> arguments;

  const HomeItem(
      this.label,
      this.walkThroughMsg,
      this.iconData,
      this.link,
      this.arguments,
      );
}

class SearchResult {
  final String Function() label;
  final List<dynamic> result;

  SearchResult(this.label, this.result);
}

class PaginationResponse {
  int offset = 0;
  int limit;
  bool isPageChange;
  PaginationResponse(this.limit, this.offset, [this.isPageChange = false]);
}

class TableHeader {
  final String label;
  final ValueChanged<TableHeader>? callBack;
  bool? isSortingRequired = false;
  bool? isAscendingOrder;
  String? apiKey;
  TableHeader(this.label,
      {this.callBack,
        this.isSortingRequired,
        this.isAscendingOrder,
        this.apiKey});
}

class TableDataRow {
  final List<TableData> tableRow;
  TableDataRow(this.tableRow);
}

class TableData {
  final String label;
  final TextStyle? style;
  final String? apiKey;
  ValueChanged<TableData>? callBack;
  TableData(this.label, {this.style, this.callBack, this.apiKey});
}

class SortBy {
  final String key;
  final bool isAscending;
  SortBy(this.key, this.isAscending);
}


class Legend {
  final String label;
  final String hexColor;

  Legend(this.label, this.hexColor);
}


class CustomFile {
  final Uint8List bytes;
  final String name;
  final String extension;

  CustomFile(this.bytes, this.name, this.extension);
}

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
//
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }
