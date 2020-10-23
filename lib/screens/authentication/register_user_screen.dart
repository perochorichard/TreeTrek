import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/services/validator_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Profile Name',
                      labelStyle: Fonts.secondaryText,
                      prefixStyle: Fonts.primaryText,
                      fillColor: Colors.white70,
                      filled: true,
                      errorStyle: TextStyle(
                          backgroundColor: Colors.white.withOpacity(0.6),
                          color: Colors.red)),
                  validator: (val) {
                    if (!ValidatorService.passwordValidator(val)) {
                      return 'password must be minimum six characters, \nat least one uppercase letter, \none lowercase letter and one number.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: Fonts.secondaryText,
                  prefixStyle: Fonts.primaryText,
                  fillColor: Colors.white70,
                  filled: true,
                  errorStyle: Fonts.secondaryText.copyWith(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      color: Colors.red),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'enter email address';
                  }
                  if (!ValidatorService.emailValidator(val)) {
                    return 'enter a valid email address';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Fonts.secondaryText,
                      prefixStyle: Fonts.primaryText,
                      fillColor: Colors.white70,
                      filled: true,
                      errorStyle: TextStyle(
                          backgroundColor: Colors.white.withOpacity(0.6),
                          color: Colors.red)),
                  validator: (val) {
                    if (!ValidatorService.passwordValidator(val)) {
                      return 'password must be minimum six characters, \nat least one uppercase letter, \none lowercase letter and one number.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: Fonts.secondaryText,
                  prefixStyle: Fonts.primaryText,
                  fillColor: Colors.white70,
                  filled: true,
                  errorStyle: Fonts.secondaryText.copyWith(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      color: Colors.red),
                ),
                validator: (val) {
                  if (val != _passwordController.text) {
                    return 'passwords do not match';
                  }
                  return null;
                },
                obscureText: true,
              ),
              BlockButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (await context.read<AuthService>().registerEmailAndPass(
                          email: _emailController.text.trim(),
                          pass: _passwordController.text.trim(),
                        )) {
                      var user = context.read<User>();
                      user.sendEmailVerification();
                      context.read<AuthService>().signOut();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Validate Email'),
                          content: Text(
                              'Please check your email for a validation link.'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                user.sendEmailVerification();
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('email verification sent'),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Text('RESEND'),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      Navigator.defaultRouteName)),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Email already in use'),
                                content: Text(
                                    'the email you have entered is already registered'),
                                actions: [
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'))
                                ],
                              ));
                    }
                  }
                },
                height: 50,
                color: CustomTheme.primaryThemeColor,
                title: Text(
                  'Sign Up',
                  style: Fonts.primaryText.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
