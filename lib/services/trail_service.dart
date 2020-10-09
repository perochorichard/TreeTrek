import 'dart:convert';

import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/services/file_service.dart';

class TrailService {
  final List<String> _paths = [
    'assets/trails/conifer_walk/coniferwalk',
  ];
  List<Trail> _trails;

  TrailService() {
    // var fService = FileService();
    // _paths.forEach((path) async {
    //   var fData = await fService.readFile(path);
    //   var jsonResponse = json.decode(fData);
    //   _trails.add(Trail.fromJson(jsonResponse));
    // });
  }

  List<Trail> get trails => [..._trails];
}
