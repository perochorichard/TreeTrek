import 'dart:async';

import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PreviewTrailScreen extends StatefulWidget {
  @override
  _PreviewTrailScreenState createState() => _PreviewTrailScreenState();
}

class _PreviewTrailScreenState extends State<PreviewTrailScreen> {
  GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(43.588380, -79.541712), zoom: 19),
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: BlockButton(
              onPressed: () {
                // TODO: start trail
              },
              title: Text(
                'Start Trail',
                style: Fonts().primaryText,
              ),
              height: 50,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
