import 'package:flutter/material.dart';
import 'file:///D:/P.R.O.G.A/Flutter%20projects/product_shop/lib/providers/products/product.dart';
import 'package:product_shop/providers/products/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = '/product-detail';

//  ProductDetailScreen(); //  final String title;

//  ProductDetailScreen({this.title});

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    final product =
        Provider.of<ProductProvider>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Text(product.description),
    );
  }
}
