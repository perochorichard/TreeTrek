import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PreviewTrailScreen extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(43.588380, -79.541712), zoom: 19),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
