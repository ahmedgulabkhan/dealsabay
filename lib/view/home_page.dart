import 'dart:convert';

import 'package:dealsabay/service/auth_service.dart';
import 'package:dealsabay/shared/loading.dart';
import 'package:dealsabay/view/settings_page.dart';
import 'package:dealsabay/widget/categories_widget.dart';
import 'package:dealsabay/widget/deal_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authenticate_page.dart';

class HomePage extends StatefulWidget {

  final String fullName;
  final String email;
  const HomePage({Key? key, required this.fullName, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isLoading = true;
  final AuthService _authService = new AuthService();
  List _dealItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDealsDetailsFromFirebase();
    getDealsDetailsFromSqlite();
  }

  Future<void> getDealsDetailsFromSqlite() async {
    final String response = await rootBundle.loadString('assets/response.json');
    final data = await json.decode(response);
    setState(() {
      _dealItems = data["SearchResult"]["Items"];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("DEALSABAY"),
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.dark
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: <Widget>[
              Container(
                height: 80.0,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Hi, ' + widget.fullName, style: TextStyle(fontSize: 18.0, color: Theme.of(context).backgroundColor), overflow: TextOverflow.ellipsis),
                )
              ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
                horizontalTitleGap: -5.0,
                title: Text('Home', style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryColor)),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(fullName: widget.fullName, email: widget.email)));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.settings, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Settings', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              ),

              ListTile(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.feedback_outlined, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Feedback', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              ),

              ListTile(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.star_rate_rounded, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Rate Us', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              ),

              ListTile(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.share, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Share with Friends', style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              ),

              Divider(color: Colors.black38, height: 2.5, thickness: 0.3, indent: 10, endIndent: 10),

              ListTile(
                onTap: () async {
                  await _authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthenticatePage()), (Route<dynamic> route) => false);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.exit_to_app, color: Color(0xFFDC143C)),
                horizontalTitleGap: -5.0,
                title: Text('Sign Out', style: TextStyle(color: Color(0xFFDC143C), fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                  child: Text('Categories', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),

                CategoriesWidget(),

                Divider(color: Colors.black38, height: 2.5, thickness: 0.3, indent: 10, endIndent: 10),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                  child: Text("Today's Deals", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
            delegate: SliverChildListDelegate(
                _dealItems.map((dealItem) => DealItemWidget(dealItem: dealItem) ).toList()
            ),
          ),
        ],
      )
    );
  }
}
