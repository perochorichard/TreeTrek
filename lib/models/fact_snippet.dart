import 'package:flutter/cupertino.dart';

class FactSnippet {
  final String imagePath;
  final String imageDesc;
  final String snippet;

  FactSnippet(
      {@required this.imagePath,
      @required this.imageDesc,
      @required this.snippet});

  factory FactSnippet.fromJson(Map<String, dynamic> data) {
    String url = '';
    if (data['image'].toString().isNotEmpty) {
      url = '${data['root']}/images/${data['image']}';
    }
    return FactSnippet(
      imagePath: url,
      imageDesc: data['imageDescription'],
      snippet: data['snippet'],
    );
  }
}
