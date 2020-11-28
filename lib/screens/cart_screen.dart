import 'package:flutter/material.dart';
import 'package:product_shop/providers/products/card.dart';
import 'package:product_shop/providers/products/order.dart';
import 'package:product_shop/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static final routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CardProvider>(context);
    return Scaffold(

      appBar: AppBar(
        title: Text("Your carts"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    "\$${cart.getTotal().toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color,
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Place order",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    placeOrder(context, cart);
                    cart.clear();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.getItemUniqCount(),
//              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (ctx, i) => CartItemWidget(
                  cart.cardItems.values.toList()[i].id,
                  cart.cardItems.values.toList()[i].title,
                  cart.cardItems.values.toList()[i].quantity,
                  cart.cardItems.values.toList()[i].price,
                  cart.cardItems.keys.toList()[i]),
            ),
          )
        ],
      ),
    );
  }

  void placeOrder(BuildContext context, CardProvider cardProvider) {
    Provider.of<OrderList>(context)
        .addOrder(cardProvider.cardItems.values.toList(), cardProvider.getTotal());
  }
}
