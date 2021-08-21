import 'package:dealsabay/view/deal_item_details_page.dart';
import 'package:flutter/material.dart';

class DealItemWidget extends StatelessWidget {

  final dealItem;
  const DealItemWidget({Key? key, required this.dealItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DealItemDetailsPage(dealItem: dealItem)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(dealItem["Images"]["Primary"]["Medium"]["URL"]))
              ),
            ),

            SizedBox(height: 7.0),

            Text(dealItem["ItemInfo"]["Title"]["DisplayValue"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),

            SizedBox(height: 5.0),

            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: "${dealItem["Offers"]["Listings"][0]["Price"]["DisplayAmount"]} ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),
                  children: <TextSpan>[
                    TextSpan(text: "(₹${dealItem["Offers"]["Listings"][0]["Price"]["Amount"] - dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"]})", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.lineThrough)),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 3.0),

            Align(
                alignment: Alignment.centerLeft,
                child: Text("(${dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"]}% off)", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis)
            ),
          ],
        ),
      ),
    );

    // body: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
    //               child: Text('Categories', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
    //             ),
    //           ],
    //         ),
    //
    //         CategoriesWidget(),
    //
    //         Divider(color: Colors.black38, height: 2.5, thickness: 0.3, indent: 10, endIndent: 10),
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
    //               child: Text("Today's Deals", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
    //             ),
    //           ],
    //         ),
    //
    //         GridView.count(
    //             crossAxisCount: 2,
    //             childAspectRatio: 0.75,
    //             children: _dealItems.map((dealItem) =>
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(context, MaterialPageRoute(builder: (context) => DealItemPage(dealItem: dealItem)));
    //                   },
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    //                     margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(color: Colors.black12, style: BorderStyle.solid),
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         Container(
    //                           height: 120,
    //                           width: 120,
    //                           decoration: BoxDecoration(
    //                             image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(dealItem["Images"]["Primary"]["Medium"]["URL"]))
    //                           ),
    //                         ),
    //
    //                         SizedBox(height: 7.0),
    //
    //                         Text(dealItem["ItemInfo"]["Title"]["DisplayValue"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
    //
    //                         SizedBox(height: 4.0),
    //
    //                         Align(
    //                           alignment: Alignment.centerLeft,
    //                           child: RichText(
    //                             text: TextSpan(
    //                               text: "${dealItem["Offers"]["Listings"][0]["Price"]["DisplayAmount"]} ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),
    //                               children: <TextSpan>[
    //                                 TextSpan(text: "(₹${dealItem["Offers"]["Listings"][0]["Price"]["Amount"] - dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"]})", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.lineThrough)),
    //                               ],
    //                             ),
    //                             maxLines: 2,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //
    //                         SizedBox(height: 4.0),
    //
    //                         Align(
    //                           alignment: Alignment.centerLeft,
    //                           child: Text("(${dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"]}% off)", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis)
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //             ).toList()
    //         )
    //       ],
    //     ),
    // )
  }
}
