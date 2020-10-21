import 'dart:collection';
import 'dart:typed_data';

import 'package:TreeTrek/models/map_tree.dart';
import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/models/trail_progress.dart';
import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/providers/image_provider.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/screens/home/maps/tree_detail_screen.dart';
import 'package:TreeTrek/services/geolocator_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  TrailProgress _progress = TrailProgress();

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
                  builder: (_) => CustomDialogBox(
                    title: Text(tree.name),
                    content:
                        'You aren\'t close enough to the tree! Try walking within the green circle around the tree.',
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
    _progress.mapTrees = _mapTrees;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context).settings.arguments as int;
    _trail = context.read<TrailsProvider>().findById(id);
    _geoService = context.read<GeolocatorService>();
    _imageService = context.read<ImageServiceProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _trail.centerCoordinate,
              zoom: _trail.zoom - 0.5,
            ),
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _polylines,
            circles: _circles,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40),
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
                          'Trees Learned (${_progress.treesSeen.length}/${_trail.trees.length})',
                          style:
                              Fonts.primaryText.copyWith(color: Colors.white),
                        ),
                      ),
                      StepProgressIndicator(
                        totalSteps: _trail.trees.length,
                        currentStep: _progress.treesSeen.length,
                        unselectedColor: Colors.white,
                        selectedColor: CustomTheme.primaryThemeColor,
                        customStep: (index, color, _) =>
                            color == CustomTheme.primaryThemeColor
                                ? Icon(
                                    Icons.circle,
                                    color: Colors.yellow,
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
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // CANCEL EXPOLORE
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: RawMaterialButton(
                            onPressed: () {
                              // TODO: cancel explore
                              showDialog(
                                context: context,
                                builder: (_) => CustomDialogBox(
                                  title: Text(
                                    'Cancel Exploring',
                                    style: Fonts.primaryText
                                        .copyWith(color: Colors.white),
                                  ),
                                  content:
                                      'Are you sure you want to cancel exploration?',
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'NO',
                                        style: Fonts.primaryText
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                            Navigator.defaultRouteName,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'OK',
                                        style: Fonts.primaryText
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.clear,
                              size: 25,
                              color: Colors.white,
                            ),
                            fillColor: Colors.red[700],
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        // // SAVE EXPLORE
                        // RawMaterialButton(
                        //   onPressed: () {
                        //     // TODO: save progress
                        //   },
                        //   child: Icon(
                        //     Icons.save,
                        //     size: 35,
                        //     color: Colors.white,
                        //   ),
                        //   fillColor: Colors.blue[700],
                        //   shape: CircleBorder(),
                        //   padding: EdgeInsets.all(10),
                        // ),
                        // SHOW TRAIL
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: RawMaterialButton(
                            onPressed: () {
                              _geoService.centerToPosition(_controller,
                                  _trail.centerCoordinate, _trail.zoom);
                            },
                            child: Icon(
                              Icons.map,
                              size: 40,
                              color: Colors.white,
                            ),
                            fillColor: CustomTheme.primaryThemeColor,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        // SHOW LOCATION
                        RawMaterialButton(
                          onPressed: () async {
                            setState(() {
                              _loadingVisible = true;
                            });
                            Position pos =
                                await _geoService.getInitialPosition();
                            double zoom = await _controller.getZoomLevel();
                            _geoService.centerToPosition(_controller,
                                LatLng(pos.latitude, pos.longitude), zoom);
                            setState(() {
                              _loadingVisible = false;
                            });
                          },
                          child: Icon(
                            Icons.gps_fixed,
                            size: 40,
                            color: Colors.white,
                          ),
                          fillColor: CustomTheme.primaryThemeColor,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  ),
                )
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
              ),
            ),
          );
        },
      ),
    );

    setState(() {
      _markers = tempMarkers;
      _circles.remove(_circles
          .firstWhere((element) => element.circleId.value == id.toString()));
      _progress.treesSeen.add(mTree);
    });

    if (_progress.treesSeen.length >= _trail.trees.length) {
      // TODO: show completion card
      print('trail complete');
      showDialog(
        context: context,
        builder: (_) => CustomDialogBox(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.eco,
                  size: 55,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  '${_trail.title} Complete!',
                  style: Fonts.primaryText.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          content:
              'Congratulations! You\'ve been an amazing tree explorer and completed ${_trail.title}. Your knowledge of trees is growing!',
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                  // TODO: UPDATE USER INFORMATION
                );
              },
              child: Text(
                'OK',
                style: Fonts.primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
