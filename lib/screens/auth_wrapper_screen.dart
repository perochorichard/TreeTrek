import 'package:TreeTrek/screens/authentication/authentication_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    print(Navigator.defaultRouteName);
    if (firebaseUser != null) {
      return TrailsScreen();
    }
    return AuthenticationScreen();
  }
}
