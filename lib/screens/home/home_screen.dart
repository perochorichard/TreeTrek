import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('details: ${context.watch<TreeTrekUser>().uid}'),
            RaisedButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: Text('sign out'),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
