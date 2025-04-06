import 'package:flutter/material.dart';
import 'package:alsharq_law_office_app/screens/login/widgets/login_form.dart';
import 'package:alsharq_law_office_app/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  LoginHeader(),
                  SizedBox(height: 48),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
