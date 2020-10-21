import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInAnon() async {
    try {
      UserCredential userCred = await _firebaseAuth.signInAnonymously();
      DatabaseService(uid: userCred.user.uid).updateUserData(
        TreeTrekUser(
          uid: userCred.user.uid,
          tavelDistanceMeters: 0,
          trailHistory: [],
          trailsCompleted: 0,
          treesSeen: 0,
        ),
      );
      return 'anonymous sign-in successful';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> signInWithEmailAndPass({String email, String pass}) async {
    try {
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      DatabaseService(uid: userCred.user.uid).updateUserData(
        TreeTrekUser(
          uid: userCred.user.uid,
          tavelDistanceMeters: 0,
          trailHistory: [],
          trailsCompleted: 0,
          treesSeen: 0,
        ),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> registerEmailAndPass({String email, String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  String signOut() {
    try {
      _firebaseAuth.signOut();
      return 'user signed out';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // TreeTrekUser userFromFirebaseUser(User user) {
  //   return user != null ? TreeTrekUser(uid: user.uid) : null;
  // }
}
