import 'package:dealsabay/view/category_deals_page.dart';
import 'package:flutter/material.dart';

class BrowseCategoryItemWidget extends StatelessWidget {

  final String categoryItem;
  const BrowseCategoryItemWidget({Key? key, required this.categoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDealsPage(category: categoryItem)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 6.5),
        margin: EdgeInsets.symmetric(horizontal: 1.7, vertical: 1.7),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/$categoryItem.jpg"))
              )
            ),

            Text(categoryItem, style: TextStyle(fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
