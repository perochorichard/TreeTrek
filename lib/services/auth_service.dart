import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

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
}
