import 'package:dealsabay/view/deal_item_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealItemWidget extends StatelessWidget {

  final dealItem;
  const DealItemWidget({Key? key, required this.dealItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isImage = true;
    bool isSavings = true;
    bool isPercentage = true;

    if (dealItem["Images"] == null || dealItem["Images"]["Primary"] == null || dealItem["Images"]["Primary"]["Large"] == null || dealItem["Images"]["Primary"]["Large"]["URL"] == null) {
      isImage = false;
    }

    if (dealItem["Offers"]["Listings"][0]["Price"]["Amount"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"] == null) {
      isSavings = false;
    }

    if (dealItem["Offers"]["Listings"][0]["Price"]["Savings"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"] == null) {
      isPercentage = false;
    }

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
            isImage ? Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(dealItem["Images"]["Primary"]["Large"]["URL"]))
              ),
            ) : Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.contain, image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVKQFZYhRFKtlmdWAH1PBN9kBmLmQl2olzAtXd35KpIRqZ6bFv2KHuMBAqyVmzdUrFZJA&usqp=CAU"))
              ),
            ),

            SizedBox(height: 7.0),

            Align(
                alignment: Alignment.centerLeft,
                child: Text(dealItem["ItemInfo"]["Title"]["DisplayValue"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis)
            ),

            SizedBox(height: 5.0),

            Align(
                alignment: Alignment.centerLeft,
                child: Text("${dealItem["Offers"]["Listings"][0]["Price"]["DisplayAmount"]} ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red), textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis)
            ),

            SizedBox(height: 3.0),

            isSavings ? Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("(₹${dealItem["Offers"]["Listings"][0]["Price"]["Amount"] + dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"]})", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black87, decoration: TextDecoration.lineThrough), textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 3.0),
                  ],
                )
            ) : SizedBox(height: 0.0),

            isPercentage ? Align(
                alignment: Alignment.centerLeft,
                child: Text("(${dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"]}% off)", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis)
            ) : SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }
}
