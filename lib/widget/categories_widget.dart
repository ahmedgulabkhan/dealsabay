import 'package:dealsabay/view/category_deals_page.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: EdgeInsets.symmetric(vertical: 7.5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.cyan,
              ),
              child: Center(child: Text('Apparel', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Apparel")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.green,
              ),
              child: Center(child: Text('Baby', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Baby")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.red,
              ),
              child: Center(child: Text('Beauty', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Beauty")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Colors.blue,
              ),
              child: Center(child: Text('Books', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Books")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.indigo,
              ),
              child: Center(child: Text('Computers', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Computers")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.purpleAccent,
              ),
              child: Center(child: Text('Furniture', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Furniture")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Colors.orange,
              ),
              child: Center(child: Text('Movies & TV', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Movies & TV")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Colors.black54,
              ),
              child: Center(child: Text('Home & Kitchen', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Home & Kitchen")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Colors.yellow,
              ),
              child: Center(child: Text('Fashion', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Fashion")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Colors.lightBlue,
              ),
              child: Center(child: Text('Electronics', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Electronics")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.indigo,
              ),
              child: Center(child: Text('Video Games', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Video Games")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.pinkAccent,
              ),
              child: Center(child: Text('Watches', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Watches")));
            },
          ),

          SizedBox(width: 10.0),

          GestureDetector(
            child: Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5),
                color: Colors.black87,
              ),
              child: Center(child: Text('Miscellaneous', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: "Miscellaneous")));
            },
          ),

          SizedBox(width: 10.0)
        ],
      ),
    );
  }
}
