import 'package:flutter/material.dart';

class ScreenNavigationProvider with ChangeNotifier {
  String _path = '/trail-list';
  String get path {
    return _path;
  }

  set path(String newPath) {
    _path = newPath;
    notifyListeners();
  }
}
