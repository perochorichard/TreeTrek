import 'package:TreeTrek/models/tree.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trail {
  final String title;
  final String description;
  final String thumbnailImageSrc;
  final int distanceMeters;

  final int id;
  final LatLng centerCoordinate;
  final double zoom;
  final List<LatLng> trailLine;

  final List<Tree> trees;

  Trail({
    @required this.title,
    @required this.description,
    @required this.thumbnailImageSrc,
    @required this.distanceMeters,
    @required this.id,
    @required this.centerCoordinate,
    @required this.zoom,
    @required this.trailLine,
    @required this.trees,
  });

  factory Trail.fromJson(Map<String, dynamic> data) {
    List<Tree> trees = [];
    final treesJson = data['trees'] as List;
    trees = treesJson.map((tree) => Tree.fromJson(tree)).toList();

    List<LatLng> trailLine = [];
    final trailLineJson = data['trailLine'] as List;
    trailLine = trailLineJson.map((coord) => LatLng.fromJson(coord)).toList();

    String url = '';
    if (data['trailImage'].toString().isNotEmpty) {
      url = '${data['root']}/images/${data['trailImage']}';
    }

    return Trail(
        title: data['title'],
        description: data['description'],
        thumbnailImageSrc: url,
        distanceMeters: data['distanceMeters'],
        id: data['id'],
        centerCoordinate: LatLng.fromJson(data['centerCoordinate']),
        zoom: data['zoom'],
        trailLine: trailLine,
        trees: trees);
  }
}
