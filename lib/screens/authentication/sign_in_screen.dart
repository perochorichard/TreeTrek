import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        // builder needed for SnackBar context
        builder: (context) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'enter email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'password'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'enter password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                BlockButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      bool signinSuccess = await context
                          .read<AuthService>()
                          .signInWithEmailAndPass(
                              email: emailController.text.trim(),
                              pass: passwordController.text.trim());
                      if (signinSuccess) {
                        var user = context.read<User>();
                        if (!user.emailVerified) {
                          context.read<AuthService>().signOut();
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Verify email'),
                              content: Text(
                                  'Account is unverified. Please check your email for the verification link.'),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('email verification sent'),
                                      ),
                                    );
                                    user.sendEmailVerification();
                                    Navigator.pop(context);
                                  },
                                  child: Text('RESEND'),
                                ),
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Invalid'),
                            content: Text(
                                'the email or password you have entered are invalid.'),
                            actions: [
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  height: 50,
                  title: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
