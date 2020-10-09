import 'dart:convert';

import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/services/file_service.dart';
import 'package:TreeTrek/services/trail_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () async {
                var fdata = await FileService()
                    .readFile('assets/trails/conifer_walk/coniferwalk');
                var jsonResponse = json.decode(fdata);
                var result = Trail.fromJson(jsonResponse);
                print(result.trees[7].snippets[0].snippet);
                //context.read<AuthService>().signOut();
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
