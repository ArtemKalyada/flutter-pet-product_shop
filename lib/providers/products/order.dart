import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_shop/providers/products/card.dart';

class Order {
  final double total;
  final List<CardItem> products;
  final int amount;
  final DateTime date;

  Order({this.total, this.products, this.amount, this.date});
}

class OrderList with ChangeNotifier {
  List<Order> _orders =[];

  OrderList();

  List<Order> get orders => [..._orders];

  void addOrder(List<CardItem> products, double total) {
    _orders.insert(
        0,
        new Order(
            total: total,
            products: products,
            amount: products.length,
            date: DateTime.now()));
    notifyListeners();
  }
}
