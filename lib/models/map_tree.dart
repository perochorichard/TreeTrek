import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/providers/image_provider.dart';
import 'package:TreeTrek/services/geolocator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTree {
  static const double clickableDistanceMeters = 10;
  final int id;
  Tree tree;
  bool learned;
  BitmapDescriptor get icon {
    return learned
        ? ImageServiceProvider().goldTree
        : ImageServiceProvider().greenTree;
  }

  MapTree({@required this.id, @required this.tree, this.learned = false});

  Future<bool> isClickable() async {
    var geo = GeolocatorService();
    Position pos = await geo.getInitialPosition();
    double dist = await geo.getDistanceBetween(pos.latitude, pos.longitude,
        tree.coordinates.latitude, tree.coordinates.longitude);
    return dist <= clickableDistanceMeters || learned;
  }
}
