import 'package:flutter/material.dart';

class CategoryDealsPage extends StatelessWidget {

  final String category;
  const CategoryDealsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        elevation: 0.0,
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
            onPressed: () => Navigator.pop(context)
        ),
      ),
    );
  }
}
