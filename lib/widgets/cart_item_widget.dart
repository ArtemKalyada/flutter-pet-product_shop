import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final double _price;
  final String _title;
  final int _quantity;

  const CartItemWidget(
    this._title,
    this._quantity,
    this._price,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(
            child: Text('\$$_price'),
          ),
        ),
        title: Text(_title),
        subtitle: Text('Total: \$${_price * _quantity}'),
        trailing: Text('$_quantity' + ' x'),
      ),
    );
  }
}
