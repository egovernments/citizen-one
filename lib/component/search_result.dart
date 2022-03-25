import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {

  final String pattern;
  final List<Map<String, dynamic>>? data;
  final ValueChanged<Map> callBack;
  const SearchResult({Key? key, this.pattern = '', this.data, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filteredData = data != null && pattern.isNotEmpty ? data?.where((e) => (e['name'].toString().toLowerCase()).contains(pattern.toLowerCase())).toList() : [];
    return Center(
      child: ListView.builder(
        itemCount: filteredData!.length,
        itemBuilder: (context, index) {
          final item = filteredData[index] as Map;
          return ListTile(
            onTap: () => callBack(item),
            title: Text("${item['name']}"),
            subtitle: Text("${item['des']}"),
          );
        },
      ),
    );
  }
}
