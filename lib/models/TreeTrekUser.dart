import 'package:flutter/cupertino.dart';

class TreeTrekUser {
  final String uid;
  double tavelDistanceMeters;
  int treesSeen;
  int trailsCompleted;
  List<int> trailHistory;
  TreeTrekUser({
    @required this.uid,
    @required this.tavelDistanceMeters,
    @required this.treesSeen,
    @required this.trailsCompleted,
    @required this.trailHistory,
  });

  String toString() {
    return '$uid\ntravelled: $tavelDistanceMeters\ntrees seen: $treesSeen\ntrails completed: $trailsCompleted\ntrail history: $trailHistory';
  }
}
