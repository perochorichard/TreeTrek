import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/services/validator_service.dart';
import 'package:TreeTrek/widgets/block_button.dart';
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
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
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'password'),
                validator: (val) {
                  if (!ValidatorService.passwordValidator(val)) {
                    return 'password must be minimum six characters, \nat least one uppercase letter, \none lowercase letter and one number.';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'confirm password'),
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
                    print("registration success");
                  }
                },
                height: 50,
                title: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
