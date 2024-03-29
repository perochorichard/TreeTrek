import 'package:TreeTrek/screens/authentication/authentication_screen.dart';
import 'package:TreeTrek/screens/home/main_navigator_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MainNavigatorScreen();
    }
    return AuthenticationScreen();
  }
}
