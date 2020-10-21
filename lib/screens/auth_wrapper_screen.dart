import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/screens/authentication/authentication_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:TreeTrek/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

class AuthWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MultiProvider(
        providers: [
          Provider<DatabaseService>(
            create: (context) => DatabaseService(uid: firebaseUser.uid),
          ),
          StreamProvider(
            create: (context) =>
                context.read<DatabaseService>().updatedTreeTrekUser,
          ),
        ],
        child: TrailsScreen(),
      );
    }
    return AuthenticationScreen();
  }
}
