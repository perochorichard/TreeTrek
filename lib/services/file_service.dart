import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<String> readFile(String path) async {
    return await rootBundle.loadString(path);
  }
}
