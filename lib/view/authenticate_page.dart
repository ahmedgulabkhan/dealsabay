import 'package:dealsabay/view/sign_in_page.dart';
import 'package:dealsabay/view/sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({Key? key}) : super(key: key);

  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {

  bool _showSignIn = true;

  void toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSignIn ? SignInPage(toggleView: toggleView) : SignUpPage(toggleView: toggleView);
  }
}
