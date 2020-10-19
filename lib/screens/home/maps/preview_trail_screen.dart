import 'dart:collection';
import 'dart:typed_data';

import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/providers/image_provider.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/services/geolocator_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PreviewTrailScreen extends StatefulWidget {
  @override
  _PreviewTrailScreenState createState() => _PreviewTrailScreenState();
}

class _PreviewTrailScreenState extends State<PreviewTrailScreen> {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polyline> _polylines = HashSet<Polyline>();

  GeolocatorService _geoService;
  ImageServiceProvider _imageService;

  Trail _trail;

  void _onMapCreated(GoogleMapController controller) async {
    // SET TREE MARKERS AND POLY LINES
    Set<Marker> tempMarkers = HashSet<Marker>();
    Set<Polyline> tempPolylines = HashSet<Polyline>();
    for (int i = 0; i < _trail.trees.length; i++) {
      Tree tree = _trail.trees[i];

      tempMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: tree.coordinates,
          icon: _imageService.greenTree,
        ),
      );

      tempPolylines.add(
        Polyline(
            polylineId: PolylineId(i.toString()),
            points: _trail.trailLine,
            visible: true,
            color: Colors.green,
            width: 5),
      );
    }
    setState(() {
      _markers = tempMarkers;
      _polylines = tempPolylines;
    });
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments as int;
    _trail = context.watch<TrailsProvider>().findById(id);
    _geoService = context.watch<GeolocatorService>();
    _imageService = context.watch<ImageServiceProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryThemeColor,
        title: Text(
          _trail.title,
          style: Fonts.primaryText.copyWith(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: _trail.centerCoordinate, zoom: _trail.zoom - 0.5),
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: RawMaterialButton(
                    onPressed: () {
                      _geoService.centerToPosition(
                          _controller, _trail.centerCoordinate, _trail.zoom);
                    },
                    child: Icon(
                      Icons.map,
                      size: 35,
                      color: Colors.white,
                    ),
                    fillColor: CustomTheme.primaryThemeColor,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    Position pos = await _geoService.getInitialPosition();
                    double zoom = await _controller.getZoomLevel();
                    _geoService.centerToPosition(
                        _controller, LatLng(pos.latitude, pos.longitude), zoom);
                  },
                  child: Icon(
                    Icons.location_on,
                    size: 35,
                    color: Colors.white,
                  ),
                  fillColor: CustomTheme.primaryThemeColor,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: BlockButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/explore',
                          arguments: _trail.id);
                    },
                    title: Text(
                      'Start Trail',
                      style: Fonts.primaryText.copyWith(color: Colors.white),
                    ),
                    height: 50,
                    color: CustomTheme.primaryThemeColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
