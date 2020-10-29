import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = '/product-detail';

//  ProductDetailScreen(); //  final String title;

//  ProductDetailScreen({this.title});

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Text(productId),
    );
  }
}
