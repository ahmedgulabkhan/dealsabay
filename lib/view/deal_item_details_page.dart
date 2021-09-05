import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class DealItemDetailsPage extends StatelessWidget {

  final dealItem;
  const DealItemDetailsPage({Key? key, required this.dealItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isSavings = true;
    bool isPercentage = true;
    bool isBrandDisplayValue = true;
    bool isManufacturerDisplayValue = true;
    List<dynamic> featuresList = [];
    List<dynamic> images = [];

    if (dealItem["Images"] != null && dealItem["Images"]["Primary"] != null && dealItem["Images"]["Primary"]["Large"] != null && dealItem["Images"]["Primary"]["Large"]["URL"] != null) {
      images.add(dealItem["Images"]["Primary"]["Large"]["URL"]);
    }

    if (dealItem["Images"] != null && dealItem["Images"]["Variants"] != null) {
      for(var i in dealItem["Images"]["Variants"]) {
        images.add(i["Large"]["URL"]);
      }
    }

    if (dealItem["Offers"]["Listings"][0]["Price"]["Amount"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"] == null) {
      isSavings = false;
    }

    if (dealItem["Offers"]["Listings"][0]["Price"]["Savings"] == null || dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"] == null) {
      isPercentage = false;
    }

    if (dealItem["ItemInfo"] == null || dealItem["ItemInfo"]["ByLineInfo"] == null || dealItem["ItemInfo"]["ByLineInfo"]["Brand"] == null || dealItem["ItemInfo"]["ByLineInfo"]["Brand"]["DisplayValue"] == null) {
      isBrandDisplayValue = false;
    }

    if (dealItem["ItemInfo"] == null || dealItem["ItemInfo"]["ByLineInfo"] == null || dealItem["ItemInfo"]["ByLineInfo"]["Manufacturer"] == null || dealItem["ItemInfo"]["ByLineInfo"]["Manufacturer"]["DisplayValue"] == null) {
      isManufacturerDisplayValue = false;
    }

    if (dealItem["ItemInfo"] != null && dealItem["ItemInfo"]["Features"] != null && dealItem["ItemInfo"]["Features"]["DisplayValues"] != null) {
      featuresList = dealItem["ItemInfo"]["Features"]["DisplayValues"];
    }

    if (images.isEmpty) {
      images.add("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVKQFZYhRFKtlmdWAH1PBN9kBmLmQl2olzAtXd35KpIRqZ6bFv2KHuMBAqyVmzdUrFZJA&usqp=CAU");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        titleSpacing: 0.0,
        elevation: 0.0,
        brightness: Brightness.dark,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: ListView(
        children: [
          images.length > 1 ? CarouselSlider(
            items: images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(imageUrl))
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width,
              aspectRatio: 1,
              viewportFraction: 1.0,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )
          ) : CarouselSlider(
              items: images.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(imageUrl))
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width,
                aspectRatio: 1,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
              )
          ),

          SizedBox(height: 15.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Text(dealItem["ItemInfo"]["Title"]["DisplayValue"], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 10.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Text("Price: ${dealItem["Offers"]["Listings"][0]["Price"]["DisplayAmount"]} ", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.red)),
          ),

          SizedBox(height: 5.0),

          isSavings ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("(₹${dealItem["Offers"]["Listings"][0]["Price"]["Amount"] + dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"]})", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black87, decoration: TextDecoration.lineThrough)),
                SizedBox(height: 5.0),
              ],
            ),
          ) : SizedBox(height: 0.0),

          isPercentage ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Text("(${dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Percentage"]}% off) | You Save: ₹${dealItem["Offers"]["Listings"][0]["Price"]["Savings"]["Amount"]}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis),
          ) : SizedBox(height: 0.0),

          Divider(color: Colors.black38, height: 30.0, thickness: 0.3, indent: 10, endIndent: 10),

          isBrandDisplayValue ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Brand: ", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                    children: <TextSpan>[
                      TextSpan(text: dealItem["ItemInfo"]["ByLineInfo"]["Brand"]["DisplayValue"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.0),
              ],
            ),
          ) : SizedBox(height: 0.0),

          isManufacturerDisplayValue ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: RichText(
              text: TextSpan(
                text: "Manufacturer: ", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(text: dealItem["ItemInfo"]["ByLineInfo"]["Manufacturer"]["DisplayValue"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ) : SizedBox(height: 0.0),

          Divider(color: Colors.black38, height: 30.0, thickness: 0.3, indent: 10, endIndent: 10),

          featuresList.isNotEmpty ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Text("Features:", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          ) : SizedBox(height: 0.0),

          for(String feature in featuresList) Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Text("● $feature", style: TextStyle(fontSize: 15.0))
          ),

          SizedBox(height: 15.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: MaterialButton(
          height: 50.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text("Grab Deal from Amazon", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          onPressed: () => {
            launch(dealItem['DetailPageURL'])
          },
          splashColor: Colors.redAccent,
        )
      ),
    );
  }
}
