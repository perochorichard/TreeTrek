import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/screens/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

class AuthWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<TreeTrekUser>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return AuthenticationScreen();
  }
}
