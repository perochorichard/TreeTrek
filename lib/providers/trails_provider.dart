import 'dart:convert';

import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/services/file_service.dart';
import 'package:flutter/cupertino.dart';

class TrailsProvider with ChangeNotifier {
  final List<String> _paths = [
    'assets/trails/conifer_walk/coniferwalk',
    'assets/trails/maple_walk/maplewalk',
    'assets/trails/gentle_giants_2_walk/gentlegiants2walk',
    'assets/trails/heritage_tree_walk/heritagetreewalk',
  ];
  List<Trail> _trails = [];

  TrailsProvider() {
    setTrails();
  }
  void setTrails() async {
    var fService = FileService();
    for (int i = 0; i < _paths.length; i++) {
      var path = _paths[i];
      var fData = await fService.readFile(path);
      var jsonResponse = json.decode(fData);
      _trails.add(Trail.fromJson(jsonResponse));
    }
    notifyListeners();
  }

  List<Trail> get trails => [..._trails];

  Trail findById(int id) {
    return _trails.firstWhere((trail) => trail.id == id);
  }
}
