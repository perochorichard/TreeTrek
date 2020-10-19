import 'dart:typed_data';

import 'package:TreeTrek/services/image_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImageServiceProvider {
  BitmapDescriptor _greenTree;
  BitmapDescriptor _goldTree;
  BitmapDescriptor _greyTree;

  BitmapDescriptor get greenTree => _greenTree;
  BitmapDescriptor get goldTree => _goldTree;
  BitmapDescriptor get greyTree => _greyTree;

  final String _path = 'assets/tree_icons';

  ImageServiceProvider() {
    _init();
  }

  void _init() async {
    ImageService ims = ImageService();
    Uint8List greenTreeAsset =
        await ims.getBytesFromAsset('$_path/GREEN.png', 100);
    Uint8List goldTreeAsset =
        await ims.getBytesFromAsset('$_path/GOLD.png', 100);
    Uint8List greyTreeAsset =
        await ims.getBytesFromAsset('$_path/GREY.png', 100);
    _greenTree = BitmapDescriptor.fromBytes(greenTreeAsset);
    _goldTree = BitmapDescriptor.fromBytes(goldTreeAsset);
    _greyTree = BitmapDescriptor.fromBytes(greyTreeAsset);
  }
}
