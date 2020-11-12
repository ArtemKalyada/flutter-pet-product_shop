import 'package:flutter/cupertino.dart';

class CardItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CardItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CardProvider with ChangeNotifier {
  Map<String, CardItem> _cardItems = {};

  CardProvider();

  Map<String, CardItem> get cardItems => _cardItems;

  int getItemCount() {
    return cardItems.values.fold(0, (prev, element) => prev + element.quantity);
  }

  double getTotal() {
    return cardItems.values.fold(0, (prev, element) {
      return prev + element.quantity * element.price;
    });
  }

  void addCardItem(String productId, String title, double price) {
    if (_cardItems.containsKey(productId)) {
      _cardItems.update(
          productId,
          (existing) => new CardItem(
              id: productId,
              title: title,
              quantity: existing.quantity + 1,
              price: existing.price));
    } else {
      _cardItems.putIfAbsent(
          productId,
          () => CardItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  int getItemUniqCount() {
    return cardItems.keys.length;
  }
}
