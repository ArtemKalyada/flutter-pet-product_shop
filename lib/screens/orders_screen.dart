import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_shop/providers/products/order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderList>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
      ),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (ctx, i) => OrderItem(orders[i])),
    );
  }
}

class OrderItem extends StatefulWidget {
  final Order order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.total}"),
            subtitle: Text(DateFormat('dd MM yyyy').format(widget.order.date)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 10, 100),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              child: ListView(
                children: (widget.order.products
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              '\$${e.price}x ${e.quantity}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ))
                    .toList()),
              ),
            )
        ],
      ),
    );
  }
}
