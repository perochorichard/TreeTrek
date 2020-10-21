import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  void updateUserData(TreeTrekUser user) async {
    await userDataCollection.doc(uid).set({
      'travel-dist': user.tavelDistanceMeters,
      'trees-seen': user.treesSeen,
      'trails-completed': user.trailsCompleted,
      'trail-history': user.trailHistory,
    });
  }

  Stream<TreeTrekUser> get updatedTreeTrekUser {
    return userDataCollection.doc(uid).snapshots().map((snapshot) {
      return _treeTrekUser(snapshot);
    });
  }

  TreeTrekUser _treeTrekUser(DocumentSnapshot snapshot) {
    var userData = snapshot.data();
    return TreeTrekUser(
      uid: uid,
      tavelDistanceMeters: userData['travel-dist'] ?? 0,
      treesSeen: userData['trees-seen'] ?? 0,
      trailsCompleted: userData['trails-completed'] ?? 0,
      trailHistory: userData['trail-history'].cast<int>() ?? [].cast<int>(),
    );
  }
}
