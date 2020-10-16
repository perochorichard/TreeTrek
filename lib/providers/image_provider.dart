import 'dart:typed_data';

import 'package:TreeTrek/services/image_service.dart';

class ImageServiceProvider {
  static Future<Uint8List> get greenTree async {
    return await ImageService()
        .getBytesFromAsset('assets/tree_icons/GREEN.png', 100);
  }

  static Future<Uint8List> get yellowTree async {
    return await ImageService()
        .getBytesFromAsset('assets/tree_icons/GOLD.png', 100);
  }

  static Future<Uint8List> get greyTree async {
    return await ImageService()
        .getBytesFromAsset('assets/tree_icons/GREY.png', 100);
  }
}
