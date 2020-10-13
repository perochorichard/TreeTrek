import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var trails = context.watch<TrailsProvider>().trails;
    return Scaffold(
      body: trails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  Text(trails.first.title),
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
