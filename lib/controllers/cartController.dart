import 'package:decornata/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  Map<String, CartModel> _items = {};

  //getter cart
  Map<String, CartModel> get items => _items;

  int get mountQty => _items.length;

  double get mountPrice {
    var mount = 0.0;
    _items.forEach((key, cartItem) {
      mount += cartItem.qty! * double.parse(cartItem.price!);
    });
    return mount;
  }

  void addCart(String productId, String title, String price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartModel(
              id: value.id,
              title: value.title,
              price: value.price,
              image: value.image,
              qty: value.qty! + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartModel(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              image: image,
              qty: 1));
    }
    notifyListeners();
  }

  // delete product on cart
  void deleteCart(String productId) {
    _items.removeWhere((key, value) => value.id == productId);
    notifyListeners();
  }
}
