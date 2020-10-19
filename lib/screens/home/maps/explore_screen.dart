import 'dart:collection';
import 'dart:typed_data';

import 'package:TreeTrek/models/map_tree.dart';
import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/providers/image_provider.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/screens/home/maps/tree_detail_screen.dart';
import 'package:TreeTrek/services/geolocator_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();

  List<MapTree> _mapTrees = [];

  GeolocatorService _geoService;
  ImageServiceProvider _imageService;

  bool _loadingVisible = false;

  Trail _trail;

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _loadingVisible = true;
    });
    Set<Marker> tempMarkers = HashSet<Marker>();
    Set<Polyline> tempPolylines = HashSet<Polyline>();
    Set<Circle> tempCircles = HashSet<Circle>();

    for (int i = 0; i < _trail.trees.length; i++) {
      Tree tree = _trail.trees[i];
      MapTree mapTree = MapTree(id: i, tree: tree);

      tempMarkers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: tree.coordinates,
            icon: _imageService.greenTree,
            anchor: Offset(0.5, 0.5),
            onTap: () async {
              setState(() {
                _loadingVisible = true;
              });
              bool clickable = await mapTree.isClickable();
              if (clickable) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreeDetailScreen(
                      tree: tree,
                      onComplete: () {
                        print('learning tree $i');
                        _learnTree(i);
                      },
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: CustomTheme.primaryThemeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(
                      tree.name,
                      style: Fonts.primaryText.copyWith(color: Colors.white),
                    ),
                    content: Text(
                      'You aren\'t close enough to the tree! Try walking within the green circle around the tree.',
                      style: Fonts.secondaryText.copyWith(color: Colors.white),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style:
                              Fonts.primaryText.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                );
              }
              setState(() {
                _loadingVisible = false;
              });
            }),
      );
      tempPolylines.add(
        Polyline(
            polylineId: PolylineId(i.toString()),
            points: _trail.trailLine,
            visible: true,
            color: Colors.green,
            width: 5),
      );
      tempCircles.add(
        Circle(
          circleId: CircleId(i.toString()),
          center: tree.coordinates,
          radius: MapTree.clickableDistanceMeters,
          fillColor: CustomTheme.primaryThemeColor.withOpacity(0.3),
          strokeWidth: 0,
        ),
      );

      _mapTrees.add(mapTree);
    }

    setState(() {
      _markers = tempMarkers;
      _polylines = tempPolylines;
      _circles = tempCircles;
      _loadingVisible = false;
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _trail.centerCoordinate,
              zoom: _trail.zoom,
            ),
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _polylines,
            circles: _circles,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  color: CustomTheme.primaryThemeColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Trees Learned',
                          style:
                              Fonts.primaryText.copyWith(color: Colors.white),
                        ),
                      ),
                      StepProgressIndicator(
                        totalSteps: _trail.trees.length,
                        unselectedColor: Colors.white,
                        selectedColor: CustomTheme.primaryThemeColor,
                        customStep: (index, color, _) =>
                            color == CustomTheme.primaryThemeColor
                                ? Icon(
                                    Icons.circle,
                                    size: 15,
                                  )
                                : Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(10),
                  child: Visibility(
                    visible: _loadingVisible,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _learnTree(int id) {
    print('id: $id');
    MapTree mTree = _mapTrees.firstWhere((element) => element.id == id);
    mTree.learned = true;
    _mapTrees[_mapTrees.indexWhere((element) => element.id == id)] = mTree;

    Set<Marker> tempMarkers = _markers;
    tempMarkers.remove(tempMarkers
        .firstWhere((element) => element.markerId.value == id.toString()));
    tempMarkers.add(
      Marker(
          markerId: MarkerId(id.toString()),
          position: _trail.trees[id].coordinates,
          anchor: Offset(0.5, 0.5),
          icon: _imageService.goldTree,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TreeDetailScreen(
                          tree: mTree.tree,
                          onComplete: () {
                            print('tree already learned');
                          },
                        )));
          }),
    );

    setState(() {
      _markers = tempMarkers;
      _circles.remove(_circles
          .firstWhere((element) => element.circleId.value == id.toString()));
    });
  }
}
