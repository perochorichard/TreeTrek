import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[350]),
              child: Column(
                children: [
                  Text('Sign In'),
                  // EMAIL SIGN IN
                  BlockButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    height: 50,
                    title: Text(
                      'With email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // GUEST SIGN IN
                  BlockButton(
                    onPressed: () {
                      context.read<AuthService>().signInAnon();
                    },
                    height: 50,
                    title: Text('As Guest'),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[350],
              ),
              child: Column(
                children: [
                  Text('New to TreeTrek?'),
                  // SIGN UP
                  BlockButton(
                    onPressed: () {
                      // TODO: SIGN UP PAGE
                      Navigator.pushNamed(context, '/register');
                    },
                    height: 50,
                    title: Text('Sign Up'),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
