import 'dart:io';

import 'package:dealsabay/hive/boxes.dart';
import 'package:dealsabay/service/database_service.dart';
import 'package:dealsabay/shared/loading.dart';
import 'package:dealsabay/widget/deal_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoryDealsPage extends StatefulWidget {

  final String category;
  const CategoryDealsPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryDealsPageState createState() => _CategoryDealsPageState();
}

class _CategoryDealsPageState extends State<CategoryDealsPage> {

  bool _isLoading = true;
  int _pageNum = 1;
  List _categoryDealItems = [];
  List _itemsFiltered = [];
  bool _showLoadMoreItemsButton = true;
  bool _isInternetConnectivity = true;
  late Box hiveBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiveBox = Boxes.getComprehensiveDeals();
    getCategoryDealsDetails();
  }

  Future<void> getCategoryDealsDetails() async {
    if (hiveBox.isNotEmpty) {
      print("HiveBox is not empty in ${widget.category} page");
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
        if (widget.category == "Apparel") {
          if (hiveBox.get("apparel-deals") != null) {
            _itemsFiltered = await hiveBox.get("apparel-deals");
          }
        } else if (widget.category == "Baby") {
          if (hiveBox.get("baby-deals") != null) {
            _itemsFiltered = await hiveBox.get("baby-deals");
          }
        } else if (widget.category == "Beauty") {
          if (hiveBox.get("beauty-deals") != null) {
            _itemsFiltered = await hiveBox.get("beauty-deals");
          }
        } else if (widget.category == "Books") {
          if (hiveBox.get("books-deals") != null) {
            _itemsFiltered = await hiveBox.get("books-deals");
          }
        } else if (widget.category == "Computers") {
          if (hiveBox.get("computers-deals") != null) {
            _itemsFiltered = await hiveBox.get("computers-deals");
          }
        } else if (widget.category == "Furniture") {
          if (hiveBox.get("furniture-deals") != null) {
            _itemsFiltered = await hiveBox.get("furniture-deals");
          }
        } else if (widget.category == "Movies & TV") {
          if (hiveBox.get("moviesandtv-deals") != null) {
            _itemsFiltered = await hiveBox.get("moviesandtv-deals");
          }
        } else if (widget.category == "Home & Kitchen") {
          if (hiveBox.get("homeandkitchen-deals") != null) {
            _itemsFiltered = await hiveBox.get("homeandkitchen-deals");
          }
        } else if (widget.category == "Fashion") {
          if (hiveBox.get("fashion-deals") != null) {
            _itemsFiltered = await hiveBox.get("fashion-deals");
          }
        } else if (widget.category == "Electronics") {
          if (hiveBox.get("electronics-deals") != null) {
            _itemsFiltered = await hiveBox.get("electronics-deals");
          }
        } else if (widget.category == "Video Games") {
          if (hiveBox.get("videogames-deals") != null) {
            _itemsFiltered = await hiveBox.get("videogames-deals");
          }
        } else if (widget.category == "Watches") {
          if (hiveBox.get("watches-deals") != null) {
            _itemsFiltered = await hiveBox.get("watches-deals");
          }
        } else if (widget.category == "Miscellaneous") {
          if (hiveBox.get("miscellaneous-deals") != null) {
            _itemsFiltered = await hiveBox.get("miscellaneous-deals");
          }
        }

        if (_itemsFiltered == null || _itemsFiltered.isEmpty) {
          print("HiveBox is not empty, but the '${widget.category}' key is empty");
          try {
            await getCategoryDealsFromFirebaseAndUpdateHive(hiveBox);
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
            _categoryDealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
            _isLoading = false;
          });
        } else {
          setState(() {
            _showLoadMoreItemsButton = false;
            _categoryDealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
            _isLoading = false;
          });
        }
      } else {
        // Delete previous data, retrieve from firebase and put in the hiveBox
        print("HiveBox is not empty in ${widget.category} page, but data has been expired");
        await hiveBox.deleteAll(["SetTime", "deals", "apparel-deals", "baby-deals", "beauty-deals", "books-deals", "computers-deals",
          "furniture-deals", "moviesandtv-deals", "homeandkitchen-deals", "fashion-deals", "electronics-deals",
          "videogames-deals", "watches-deals", "miscellaneous-deals"]);
        try {
          final result = await InternetAddress.lookup("google.com");
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            await getCategoryDealsFromFirebaseAndUpdateHive(hiveBox);
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
      print("HiveBox is not empty in ${widget.category} page");
      try {
        final result = await InternetAddress.lookup("google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await getCategoryDealsFromFirebaseAndUpdateHive(hiveBox);
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

  Future<void> getCategoryDealsFromFirebaseAndUpdateHive(hiveBox) async {
    List items = [];
    if (widget.category == "Apparel") {
      items = await DatabaseService().getApparelDealsFromFirestore();
    } else if (widget.category == "Baby") {
      items = await DatabaseService().getBabyDealsFromFirestore();
    } else if (widget.category == "Beauty") {
      items = await DatabaseService().getBeautyDealsFromFirestore();
    } else if (widget.category == "Books") {
      items = await DatabaseService().getBooksDealsFromFirestore();
    } else if (widget.category == "Computers") {
      items = await DatabaseService().getComputersDealsFromFirestore();
    } else if (widget.category == "Furniture") {
      items = await DatabaseService().getFurnitureDealsFromFirestore();
    } else if (widget.category == "Movies & TV") {
      items = await DatabaseService().getMovesAndTVDealsFromFirestore();
    } else if (widget.category == "Home & Kitchen") {
      items = await DatabaseService().getHomeAndKitchenDealsFromFirestore();
    } else if (widget.category == "Fashion") {
      items = await DatabaseService().getFashionDealsFromFirestore();
    } else if (widget.category == "Electronics") {
      items = await DatabaseService().getElectronicsDealsFromFirestore();
    } else if (widget.category == "Video Games") {
      items = await DatabaseService().getVideoGamesDealsFromFirestore();
    } else if (widget.category == "Watches") {
      items = await DatabaseService().getWatchesDealsFromFirestore();
    } else if (widget.category == "Miscellaneous") {
      items = await DatabaseService().getMiscellaneousDealsFromFirestore();
    }

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

    if (widget.category == "Apparel") {
      hiveBox.put("apparel-deals", _itemsFiltered);
    } else if (widget.category == "Baby") {
      hiveBox.put("baby-deals", _itemsFiltered);
    } else if (widget.category == "Beauty") {
      hiveBox.put("beauty-deals", _itemsFiltered);
    } else if (widget.category == "Books") {
      hiveBox.put("books-deals", _itemsFiltered);
    } else if (widget.category == "Computers") {
      hiveBox.put("computers-deals", _itemsFiltered);
    } else if (widget.category == "Furniture") {
      hiveBox.put("furniture-deals", _itemsFiltered);
    } else if (widget.category == "Movies & TV") {
      hiveBox.put("moviesandtv-deals", _itemsFiltered);
    } else if (widget.category == "Home & Kitchen") {
      hiveBox.put("homeandkitchen-deals", _itemsFiltered);
    } else if (widget.category == "Fashion") {
      hiveBox.put("fashion-deals", _itemsFiltered);
    } else if (widget.category == "Electronics") {
      hiveBox.put("electronics-deals", _itemsFiltered);
    } else if (widget.category == "Video Games") {
      hiveBox.put("videogames-deals", _itemsFiltered);
    } else if (widget.category == "Watches") {
      hiveBox.put("watches-deals", _itemsFiltered);
    } else if (widget.category == "Miscellaneous") {
      hiveBox.put("miscellaneous-deals", _itemsFiltered);
    }

    if (_itemsFiltered.length > 10) {
      setState(() {
        _categoryDealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
        _isLoading = false;
      });
    } else {
      setState(() {
        _showLoadMoreItemsButton = false;
        _categoryDealItems = _itemsFiltered.sublist(0, _itemsFiltered.length < 10 ? (_itemsFiltered.length - 1) : 10);
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

  void loadMoreItems() {
    if (_itemsFiltered.length <= (_pageNum + 1) * 10)  {
      setState(() {
        _showLoadMoreItemsButton = false;
        _pageNum++;
        _categoryDealItems = _itemsFiltered.sublist(0, _itemsFiltered.length);
      });
    } else {
      setState(() {
        _pageNum++;
        _categoryDealItems = _itemsFiltered.sublist(0, (_itemsFiltered.length < (_pageNum * 10)) ? _itemsFiltered.length : (_pageNum * 10));
      });
    }
  }

  Future<void> retryInternetConnectivity() async {
    setState(() {
      _isLoading = true;
      _isInternetConnectivity = true;
    });

    getCategoryDealsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        elevation: 0.0,
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
            onPressed: () => Navigator.pop(context)
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
      ) : _categoryDealItems.isNotEmpty ? CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72),
              delegate: SliverChildListDelegate(
                  _categoryDealItems.map((dealItem) => DealItemWidget(dealItem: dealItem)).toList()
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
      ) : Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0),
          child: Text("No '${widget.category}' deals found for today, you can check other categories in the meantime.", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        )
      ),
    );
  }
}
