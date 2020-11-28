import 'package:flutter/material.dart';
import 'package:product_shop/providers/products/card.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String _id;
  final double _price;
  final String _title;
  final int _quantity;
  final String _productId;

  const CartItemWidget(
    this._id,
    this._title,
    this._quantity,
    this._price,
    this._productId,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(_id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Remove cart?'),
                  content: Text('Should be cart removed?'),
                  actions: [
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: () => Navigator.of(context).pop(false),
                    )
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<CardProvider>(context, listen: false)
            .removeCart(_productId);
      },
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$$_price'),
            ),
          ),
          title: Text(_title),
          subtitle: Text('Total: \$${_price.toStringAsFixed(2) * _quantity}'),
          trailing: Text('$_quantity' + ' x'),
        ),
      ),
    );
  }
}
