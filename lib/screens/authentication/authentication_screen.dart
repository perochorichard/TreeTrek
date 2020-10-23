import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/trails/maple_walk/images/maple_walk_thumbnail.png'),
              fit: BoxFit.cover),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.3)),
              child: Column(
                children: [
                  Text(
                    'TreeTrek',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      height: 2,
                    ),
                  ),
                  Text(
                    'Sign In',
                    style: Fonts.primaryText.copyWith(color: Colors.white),
                  ),
                  // EMAIL SIGN IN
                  BlockButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    height: 50,
                    title: Text(
                      'With email',
                      style: Fonts.secondaryText.copyWith(color: Colors.white),
                    ),
                    color: CustomTheme.primaryThemeColor,
                  ),
                  // GUEST SIGN IN
                  BlockButton(
                    onPressed: () {
                      context.read<AuthService>().signInAnon();
                    },
                    height: 50,
                    title: Text(
                      'As Guest',
                      style: Fonts.secondaryText,
                    ),
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
                color: Colors.black.withOpacity(0.3),
              ),
              child: Column(
                children: [
                  Text(
                    'New to TreeTrek?',
                    style: Fonts.primaryText.copyWith(color: Colors.white),
                  ),
                  // SIGN UP
                  BlockButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    height: 50,
                    title: Text(
                      'Sign Up',
                      style: Fonts.secondaryText,
                    ),
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
