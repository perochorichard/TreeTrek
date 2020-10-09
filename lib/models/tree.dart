import 'package:TreeTrek/models/fact_snippet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tree {
  final String name;
  final String scientificName;
  final LatLng coordinates;
  final int heightMeters;
  final bool isNative;
  final List<FactSnippet> snippets;

  Tree(
      {@required this.name,
      @required this.scientificName,
      @required this.coordinates,
      @required this.heightMeters,
      @required this.isNative,
      @required this.snippets});

  factory Tree.fromJson(Map<String, dynamic> data) {
    List<FactSnippet> snippets = [];
    var snippetJson = data['factSnippets'] as List;
    snippets =
        snippetJson.map((snippet) => FactSnippet.fromJson(snippet)).toList();
    return Tree(
        name: data['name'],
        scientificName: data['scientificName'],
        coordinates: LatLng.fromJson(data['coordinates']),
        heightMeters: data['averageHeightMeters'],
        isNative: data['isNative'],
        snippets: snippets);
  }
}
