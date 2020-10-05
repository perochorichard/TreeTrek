import 'package:TreeTrek/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In to TreeTrek'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          onPressed: () {
            context.read<AuthService>().signInAnon();
          },
          child: Text('as Guest'),
        ),
      ),
    );
  }
}
