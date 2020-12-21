import 'package:flutter/material.dart';
import 'package:product_shop/providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          ..._getDrawerItem(
              context, Icon(Icons.shop), 'Shop', () => _pushTo(context, '/')),
          ..._getDrawerItem(context, Icon(Icons.payment), 'Orders', () {
            _pushTo(context, OrdersScreen.routeName);
          }),
          ..._getDrawerItem(context, Icon(Icons.edit), 'Manage Products', () {
            _pushTo(context, UserProductsScreen.routeName);
          }),
          ..._getDrawerItem(context, Icon(Icons.exit_to_app), 'Logout', () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          }),
        ],
      ),
    );
  }

  List<Widget> _getDrawerItem(
      BuildContext context, Icon icon, String itemText, Function onTap) {
    return List.of([
      Divider(),
      ListTile(
        leading: icon,
        title: Text(itemText),
        onTap: onTap,
      ),
    ]);
  }

  void _pushTo(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }
}
