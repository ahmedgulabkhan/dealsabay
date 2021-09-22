import 'dart:io';

import 'package:dealsabay/hive/boxes.dart';
import 'package:dealsabay/service/auth_service.dart';
import 'package:dealsabay/service/database_service.dart';
import 'package:dealsabay/shared/loading.dart';
import 'package:dealsabay/view/browse_category_page.dart';
import 'package:dealsabay/view/settings_page.dart';
import 'package:dealsabay/widget/categories_widget.dart';
import 'package:dealsabay/widget/deal_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mailto/mailto.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int _pageNum = 1;
  List _dealItems = [];
  List _itemsFiltered = [];
  bool _showLoadMoreItemsButton = true;
  bool _isInternetConnectivity = true;
  late Box hiveBox;
  final AuthService _authService = new AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiveBox = Boxes.getComprehensiveDeals();
    getDealsDetails();
  }

  Future<void> getDealsDetails() async {
    if (hiveBox.isNotEmpty) {
      print("HiveBox is not empty in deals page");
      try {
        final result = await InternetAddress.lookup("google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print("Connected to the Internet");
        }
      } on SocketException catch(_) {
        print("No internet connection");
        setState(() {
          _isInternetConnectivity = false;
          _isLoading = false;
        });
        return;
      }

      DateTime setTime = await hiveBox.get('SetTime');

      if (!isHiveDataExpired(setTime)) {
        if (hiveBox.get("deals") != null) {
          _itemsFiltered = await hiveBox.get("deals");
        }

        if (_itemsFiltered == null || _itemsFiltered.isEmpty) {
          print("HiveBox is not empty, but the 'deals' key is empty");
          try {
            await getDealsFromFirebaseAndUpdateHive();
          } catch(e) {
            print("No internet connection");
            setState(() {
              _isInternetConnectivity = false;
              _isLoading = false;
            });
            return;
          }
        }

        if (_itemsFiltered.length > 10) {
          setState(() {
            _dealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
            _isLoading = false;
          });
        } else {
          setState(() {
            _showLoadMoreItemsButton = false;
            _dealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
            _isLoading = false;
          });
        }
      } else {
        // Delete previous data, retrieve from firebase and put in the hiveBox
        print("HiveBox is not empty in deals page, but data has been expired");
        await hiveBox.deleteAll(["SetTime", "deals", "apparel-deals", "baby-deals", "beauty-deals", "books-deals", "computers-deals",
          "furniture-deals", "moviesandtv-deals", "homeandkitchen-deals", "fashion-deals", "electronics-deals",
          "videogames-deals", "watches-deals", "miscellaneous-deals"]);
        try {
          final result = await InternetAddress.lookup("google.com");
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            await getDealsFromFirebaseAndUpdateHive();
          }
        } on SocketException catch(_) {
          print("No internet connection");
          setState(() {
            _isInternetConnectivity = false;
            _isLoading = false;
          });
          return;
        }
      }
    } else {
      print("HiveBox is empty in deals page");
      try {
        final result = await InternetAddress.lookup("google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await getDealsFromFirebaseAndUpdateHive();
        }
      } on SocketException catch(_) {
        print("No internet connection");
        setState(() {
          _isInternetConnectivity = false;
          _isLoading = false;
        });
        return;
      }
    }
  }
  
  Future<void> getDealsFromFirebaseAndUpdateHive() async {
    List items = await DatabaseService().getDealsFromFirestore();
    _itemsFiltered = items.where((item) {
      if (item == null || item["ItemInfo"] == null || item["ItemInfo"]["Title"] == null || item["ItemInfo"]["Title"]["DisplayValue"] == null ||
          item["Offers"] == null || item["Offers"]["Listings"] == null || item["Offers"]["Listings"][0] == null || item["Offers"]["Listings"][0]["Price"] == null || item["Offers"]["Listings"][0]["Price"]["DisplayAmount"] == null || item["Offers"]["Listings"][0]["Price"]["Amount"] == 0 ||
          item["DetailPageURL"] == null
      ) {
        return false;
      }

      return true;
    }).toList();

    hiveBox.put("SetTime", DateTime.now());
    hiveBox.put("deals", _itemsFiltered);

    if (_itemsFiltered.length > 10) {
      setState(() {
        _dealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
        _isLoading = false;
      });
    } else {
      setState(() {
        _showLoadMoreItemsButton = false;
        _dealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
        _isLoading = false;
      });
    }
  }

  bool isHiveDataExpired(setTime) {
    if (setTime == null || DateTime.now().difference(setTime).inHours >= 5 || DateTime.now().year - setTime.year >= 1 || DateTime.now().month - setTime.month >= 1 || DateTime.now().day - setTime.day >= 1) {
      return true;
    }
    return false;
  }

  Future<void> sendFeedbackMail() async {
    final mailtoLink = Mailto(to: ['dealsabay@gmail.com'], subject: 'Feedback for Dealsabay');
    await launch('$mailtoLink');
  }

  Future<void> giveRatingOnPlayStore() async {
    await launch("https://play.google.com/store/apps/details?id=com.dealsabay.dealsabay");
  }

  Future<void> shareLinkWithFriends(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final String text = "Download the Dealsabay app and find amazing deals online, every single day! 🎉🎉 \n https://play.google.com/store/apps/details?id=com.dealsabay.dealsabay";

    await Share.share(
        text,
        subject: "Download the Dealsabay app and find amazing deals online",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
  }

  void loadMoreItems() {
    if (_itemsFiltered.length <= (_pageNum + 1) * 10)  {
      setState(() {
        _showLoadMoreItemsButton = false;
        _pageNum++;
        _dealItems = _itemsFiltered.sublist(0, _itemsFiltered.length);
      });
    } else {
      setState(() {
        _pageNum++;
        _dealItems = _itemsFiltered.sublist(0, (_itemsFiltered.length < (_pageNum * 10)) ? _itemsFiltered.length : (_pageNum * 10));
      });
    }
  }

  Future<void> retryInternetConnectivity() async {
    setState(() {
      _isLoading = true;
      _isInternetConnectivity = true;
    });

    getDealsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BrowseCategoryPage(fullName: widget.fullName, email: widget.email)));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.category_rounded, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Browse Categories', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(fullName: widget.fullName, email: widget.email)));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.settings, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Settings', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),

              ListTile(
                onTap: () async {
                  await sendFeedbackMail();
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.feedback_outlined, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Feedback', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),

              ListTile(
                onTap: () async {
                  await giveRatingOnPlayStore();
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.star_rate_rounded, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Rate us on PlayStore', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),

              ListTile(
                onTap: () async {
                  await shareLinkWithFriends(context);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.share, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Share with Friends', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
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
                title: Text('Sign Out', style: TextStyle(fontSize: 16.0, color: Color(0xFFDC143C))),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading ? Loading() : !_isInternetConnectivity ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Internet Connection", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

            SizedBox(
              width: 130,
              child: RaisedButton(
                  elevation: 0.0,
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5), side: BorderSide(color: Colors.black87, width: 0.1)),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Refresh ", style: TextStyle(fontSize: 18.0, color: Colors.black87)),
                        WidgetSpan(child: Icon(Icons.refresh, size: 18, color: Colors.green)),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await retryInternetConnectivity();
                  }
              ),
            ),
          ],
        ),
      ) : CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                  child: Text('Categories', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),

                CategoriesWidget(fullName: widget.fullName, email: widget.email),

                Divider(color: Colors.black38, height: 20.0, thickness: 0.3, indent: 10, endIndent: 10),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                  child: Text("Popular Deals", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72),
            delegate: SliverChildListDelegate(
              _dealItems.map((dealItem) => DealItemWidget(dealItem: dealItem)).toList()
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _showLoadMoreItemsButton ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5), side: BorderSide(color: Colors.black87, width: 0.1)),
                    child: Text('Load more items', style: TextStyle(color: Colors.black87, fontSize: 14.0)),
                    onPressed: () {
                      loadMoreItems();
                    }
                ),
              ) : SizedBox(height: 0.0),

              SizedBox(height: 40.0)
            ])
          ),
        ]
      ),
    );
  }
}
