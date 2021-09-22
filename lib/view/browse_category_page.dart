import 'package:dealsabay/service/auth_service.dart';
import 'package:dealsabay/view/authenticate_page.dart';
import 'package:dealsabay/view/home_page.dart';
import 'package:dealsabay/view/settings_page.dart';
import 'package:dealsabay/widget/browse_category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowseCategoryPage extends StatelessWidget {

  final String fullName;
  final String email;
  const BrowseCategoryPage({Key? key, required this.fullName, required this.email}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = new AuthService();
    final _browseCategoryItems = ['Apparel', 'Baby', 'Beauty', 'Books', 'Computers', 'Furniture', 'Movies & TV',
    'Home & Kitchen', 'Fashion', 'Electronics', 'Video Games', 'Watches', 'Miscellaneous'];

    return Scaffold(
      appBar: AppBar(
          title: Text("Categories"),
          elevation: 0.0,
          centerTitle: false,
          titleSpacing: 0.0,
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
                    child: Text('Hi, ' + fullName, style: TextStyle(fontSize: 18.0, color: Theme.of(context).backgroundColor), overflow: TextOverflow.ellipsis),
                  )
              ),

              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(fullName: fullName, email: email)));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.home, color: Colors.black87),
                horizontalTitleGap: -5.0,
                title: Text('Home', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
              ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                leading: Icon(Icons.category_rounded, color: Theme.of(context).primaryColor),
                horizontalTitleGap: -5.0,
                title: Text('Browse Categories', style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryColor)),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(fullName: fullName, email: email)));
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
      body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                    child: Text('Shop Deals by Categories', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ),

                  SizedBox(height: 10.0)
                ],
              ),
            ),

            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.72),
              delegate: SliverChildListDelegate(
                  _browseCategoryItems.map((categoryItem) => BrowseCategoryItemWidget(categoryItem: categoryItem)).toList()
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 30.0)
                ],
              ),
            ),
          ]
      ),
    );
  }
}
