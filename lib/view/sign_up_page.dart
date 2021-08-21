import 'package:dealsabay/service/auth_service.dart';
import 'package:dealsabay/shared/constants.dart';
import 'package:dealsabay/shared/loading.dart';
import 'package:dealsabay/util/helper_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {

  final Function toggleView;
  const SignUpPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _error = '';
  final AuthService _authService = new AuthService();
  TextEditingController _fullNameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();
  TextEditingController _confirmPasswordEditingController = new TextEditingController();
  TextEditingController _mobileNumberEditingController = new TextEditingController();

  onRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _authService.registerWithEmailAndPassword(_fullNameEditingController.text, _emailEditingController.text, _passwordEditingController.text, _mobileNumberEditingController.text).then((result) async {
        if (result != null) {
          if (result.toString().contains("Error: ")) {
            setState(() {
              _error = result.toString();
              _isLoading = false;
            });
          }
          else {
            await HelperFunctions.saveUserLoggedInSharedPreference(true);
            await HelperFunctions.saveUserEmailSharedPreference(_emailEditingController.text);
            await HelperFunctions.saveUserFullNameSharedPreference(_fullNameEditingController.text);

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(fullName: _fullNameEditingController.text, email: _emailEditingController.text)));
          }
        }
        else {
          setState(() {
            _error = 'Error while registering the user.';
            _isLoading = false;
          });
        }
      });
    }
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
              children: <Widget>[
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
                        Text("Sign Up", style: TextStyle(color: Colors.black87, fontSize: 25.0)),
                      ],
                    ),

                    SizedBox(height: 5.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign In',
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
                        ),
                      ],
                    ),

                    SizedBox(height: 15.0),

                    TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: _fullNameEditingController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(color: Colors.black38),
                            prefixIcon: Icon(Icons.person, color: Colors.black87)
                        ),
                        validator: (val) => val!.isEmpty ? 'This field cannot be blank' : null
                    ),

                    SizedBox(height: 10.0),

                    TextFormField(
                      style: TextStyle(color: Colors.black87),
                      controller: _emailEditingController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black38),
                          prefixIcon: Icon(Icons.alternate_email, color: Colors.black87)
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
                          prefixIcon: Icon(Icons.lock, color: Colors.black87)
                      ),
                      validator: (val) => val!.length < 6 ? 'Password not strong enough' : null,
                      obscureText: true,
                    ),

                    SizedBox(height: 10.0),

                    TextFormField(
                      style: TextStyle(color: Colors.black87),
                      controller: _confirmPasswordEditingController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Confirm password',
                        hintStyle: TextStyle(color: Colors.black38),
                        prefixIcon: Icon(Icons.lock, color: Colors.black87),
                      ),
                      validator: (val) => val == _passwordEditingController.text ? null : 'Does not match the password',
                      obscureText: true,
                    ),

                    SizedBox(height: 10.0),

                    TextFormField(
                      style: TextStyle(color: Colors.black87),
                      controller: _mobileNumberEditingController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Mobile number',
                        hintStyle: TextStyle(color: Colors.black38),
                        prefixIcon: Icon(Icons.phone, color: Colors.black87),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (val) => val!.length == 10  ? null : 'Mobile Number must be of 10 digits',
                    ),

                    SizedBox(height: 15.0),

                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                          elevation: 0.0,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          child: Text('Sign Up', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 16.0)),
                          onPressed: () {
                            onRegister();
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
                          label: Text('Sign up with Google', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
                          icon: Image.asset("assets/google_logo.png", height: 25),
                          onPressed: () {
                            // onSignInWithGoogle();
                          }
                      ),
                    ),

                    SizedBox(height: 10.0),

                    Text(_error, style: TextStyle(color: Colors.red, fontSize: 14.0), textAlign: TextAlign.center)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

