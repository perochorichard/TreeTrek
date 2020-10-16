import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageService {
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
          .buffer
          .asUint8List();
    } catch (e) {
      print('from ${this.runtimeType}: error retrieving image \'$path\'');
      return null;
    }
  }
}
