import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealsabay/service/auth_service.dart';
import 'package:dealsabay/service/database_service.dart';
import 'package:dealsabay/shared/constants.dart';
import 'package:dealsabay/shared/loading.dart';
import 'package:dealsabay/util/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {

  final Function toggleView;
  const SignInPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _isLoading = false;
  String _error = '';
  final AuthService _authService = new AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();

  onSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _authService.signInWithEmailAndPassword(_emailEditingController.text, _passwordEditingController.text).then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot = await DatabaseService(uid: result.uid).getUserData(_emailEditingController.text);

          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.saveUserEmailSharedPreference(_emailEditingController.text);
          await HelperFunctions.saveUserFullNameSharedPreference(userInfoSnapshot.docs[0].get('fullName'));
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(fullName: userInfoSnapshot.docs[0].get('fullName'), email: _emailEditingController.text)));
        }
        else {
          setState(() {
            _error = 'Invalid Email and/or password combination.';
            _isLoading = false;
          });
        }
      });
    }
  }

  onSignInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    await _authService.signInWithGoogle().then((result) async {
      if (result != null) {
        await HelperFunctions.saveUserLoggedInSharedPreference(true);
        await HelperFunctions.saveUserEmailSharedPreference(result.email);
        await HelperFunctions.saveUserFullNameSharedPreference(result.displayName);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(fullName: result.displayName, email: result.email)));
      }
      else {
        setState(() {
          _error = 'Error signing in with the given credentials.';
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 40.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      height: MediaQuery.of(context).size.height/4.5,
                      decoration: BoxDecoration(
                        // color: Colors.black38,
                        image: DecorationImage(
                          image: AssetImage("assets/dealsabay_logo.png"),
                          fit: BoxFit.contain
                        )
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Sign In", style: TextStyle(color: Colors.black87, fontSize: 25.0)),
                    ],
                  ),

                  SizedBox(height: 5.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register here',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                widget.toggleView();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 15.0),

                  TextFormField(
                    style: TextStyle(color: Colors.black87),
                    controller: _emailEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black38),
                      prefixIcon: Icon(Icons.alternate_email, color: Colors.black87),
                    ),
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Please enter a valid email";
                    },
                  ),

                  SizedBox(height: 10.0),

                  TextFormField(
                    style: TextStyle(color: Colors.black87),
                    controller: _passwordEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black38),
                      prefixIcon: Icon(Icons.lock, color: Colors.black87),
                    ),
                    validator: (val) => val!.length == 0 ? 'Password cannot be blank' : null,
                    obscureText: true,
                  ),

                  SizedBox(height: 15.0),

                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                        elevation: 0.0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Sign In', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 16.0)),
                        onPressed: () {
                          onSignIn();
                        }
                    ),
                  ),

                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(color: Colors.black38, height: 40.0, thickness: 0.5, indent: 6.0, endIndent: 6.0),
                        ),

                        Text("OR", style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),

                        Expanded(
                            child: Divider(color: Colors.black38, height: 40.0, thickness: 0.5, indent: 6.0, endIndent: 6.0),
                        ),
                      ]
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton.icon(
                        elevation: 0.0,
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.black87)),
                        label: Text('Sign In with Google', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
                        icon: Image.asset("assets/google_logo.png", height: 25),
                        onPressed: () {
                          onSignInWithGoogle();
                        }
                    ),
                  ),

                  SizedBox(height: 10.0),

                  Text(_error, style: TextStyle(color: Colors.red, fontSize: 14.0), textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
