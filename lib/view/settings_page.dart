import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  final String fullName;
  final String email;
  const SettingsPage({Key? key, required this.fullName, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0.0,
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(email)
                ],
              ),
            ),

            SizedBox(height: 5.0),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(fullName)
                ],
              ),
            ),

            SizedBox(height: 15.0),
            
            Text("Copyright © 2021 Dealsabay", style: TextStyle(color: Colors.black45, fontSize: 14.0, letterSpacing: 1.3, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
