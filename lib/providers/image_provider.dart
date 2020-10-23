import 'dart:typed_data';

import 'package:TreeTrek/services/image_service.dart';

class ImageServiceProvider {
  Future<Uint8List> get greenTree async {
    return await ImageService().getBytesFromAsset('$_path/GREEN.png', 100);
  }

  Future<Uint8List> get goldTree async {
    return await ImageService().getBytesFromAsset('$_path/GREEN.png', 100);
  }

  Future<Uint8List> get greyTree async {
    return await ImageService().getBytesFromAsset('$_path/GREEN.png', 100);
  }

  final String _path = 'assets/tree_icons';
}
