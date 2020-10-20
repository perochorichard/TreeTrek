import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  void updateUserData(TreeTrekUser user) {
    userDataCollection.doc(uid).set({
      'travel-dist': user.tavelDistanceMeters,
      'trees-seen': user.treesSeen,
      'trails-completed': user.trailsCompleted,
    });
  }
}
