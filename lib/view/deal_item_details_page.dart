import 'package:flutter/material.dart';

class DealItemDetailsPage extends StatelessWidget {

  final dealItem;
  const DealItemDetailsPage({Key? key, required this.dealItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.dark,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
            onPressed: () => Navigator.pop(context)
        ),
      ),
    );
  }
}
