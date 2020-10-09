import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  Future updateTrailHistory() {}

  Future updateStats() {}
}
