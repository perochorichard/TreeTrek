import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<TreeTrekUser> get authStateChanges => _firebaseAuth
      .authStateChanges()
      .map((User user) => userFromFirebaseUser(user));

  Future<String> signInAnon() async {
    try {
      _firebaseAuth.signInAnonymously();
      return 'anonymous sign-in successful';
    } on FirebaseAuthException catch (e) {
      return e.message;
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

  TreeTrekUser userFromFirebaseUser(User user) {
    return user != null ? TreeTrekUser(uid: user.uid) : null;
  }
}
