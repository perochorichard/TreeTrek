import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/services/image_service.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:TreeTrek/providers/image_provider.dart';

class PreviewTrailScreen extends StatefulWidget {
  @override
  _PreviewTrailScreenState createState() => _PreviewTrailScreenState();
}

class _PreviewTrailScreenState extends State<PreviewTrailScreen> {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polyline> _polylines = HashSet<Polyline>();

  Uint8List _greenTree;
  Uint8List _yellowTree;
  Uint8List _greyTree;

  Trail _trail;

  void _onMapCreated(GoogleMapController controller) async {
    _greenTree = await ImageServiceProvider.greenTree;
    _yellowTree = await ImageServiceProvider.yellowTree;
    _greyTree = await ImageServiceProvider.greyTree;

    // SET TREE MARKERS AND POLY LINES
    Set<Marker> tempMarkers = HashSet<Marker>();
    Set<Polyline> tempPolylines = HashSet<Polyline>();
    for (int i = 0; i < _trail.trees.length; i++) {
      Tree tree = _trail.trees[i];

      tempMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: tree.coordinates,
          icon: BitmapDescriptor.fromBytes(_greenTree),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: _trail.centerCoordinate, zoom: 16),
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _polylines,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: BlockButton(
              onPressed: () async {
                _updateTree('0');
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

  void _updateTree(String id) {
    Set<Marker> tempMarkers = _markers;
    tempMarkers.remove(
        tempMarkers.firstWhere((element) => element.markerId.value == id));
    tempMarkers.add(
      Marker(
        markerId: MarkerId(id),
        position: _trail.trees[int.parse(id)].coordinates,
        icon: BitmapDescriptor.fromBytes(_yellowTree),
      ),
    );
    setState(() {
      _markers = tempMarkers;
    });
  }
}
