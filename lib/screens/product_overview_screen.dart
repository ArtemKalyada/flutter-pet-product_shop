import 'package:flutter/material.dart';
import 'package:product_shop/providers/products/card.dart';
import 'file:///D:/P.R.O.G.A/Flutter%20projects/product_shop/lib/providers/products/product.dart';
import 'package:product_shop/providers/products/products.dart';
import 'package:product_shop/screens/cart_screen.dart';
import 'package:product_shop/screens/edit_product_screen.dart';
import 'package:product_shop/screens/orders_screen.dart';
import 'package:product_shop/widgets/badge.dart';
import 'package:product_shop/widgets/product_grid.dart';
import 'package:product_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum Favorites { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showFavorite = false;

  @override
  Widget build(BuildContext context) {
//    final itemCount = Provider.of<CardProvider>(context).getItemCount();
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(children: [
          AppBar(
            title: Text("Drewer"),
          ),
          ListTile(
            title: Text("Orders"),
            leading: Icon(Icons.credit_card),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            title: Text("Your products"),
            leading: Icon(Icons.credit_card),
            onTap: () {
              Navigator.of(context).pushNamed(EditProductScreen.route);
            },
          )
        ]),
      ),
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          Consumer<CardProvider>(
            builder: (ctx, cart, child) => Badge(
              child: child,
              value: cart.getItemCount().toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
          PopupMenuButton<Favorites>(
            icon: Icon(Icons.more_vert),
            onSelected: (Favorites result) {
              setState(() {
                if (result == Favorites.all) {
                  showFavorite = false;
                } else {
                  showFavorite = true;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem<Favorites>(
                value: Favorites.all,
                child: Text("Show all"),
              ),
              const PopupMenuItem<Favorites>(
                value: Favorites.favorite,
                child: Text("Show favorites"),
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(showFavorite),
    );
  }
}
