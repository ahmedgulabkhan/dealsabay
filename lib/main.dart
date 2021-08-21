import 'package:dealsabay/util/helper_functions.dart';
import 'package:dealsabay/view/authenticate_page.dart';
import 'package:dealsabay/view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? _isLoggedIn;
  String _fullName = '';
  String _email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((isLoggedInVal) async {
      if (isLoggedInVal == true) {
        await HelperFunctions.getUserFullNameSharedPreference().then((userFullNameVal) {
          setState(() {
            _isLoggedIn = isLoggedInVal;
            _fullName = userFullNameVal!;
          });
        });

        await HelperFunctions.getUserEmailSharedPreference().then((userEmailVal) {
          setState(() {
            _email = userEmailVal!;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dealsabay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(245, 71, 72, 1.0),
          backgroundColor: Colors.white
      ),
      home: (_isLoggedIn == true) ? HomePage(fullName: _fullName, email: _email) : AuthenticatePage(),
    );
  }
}

