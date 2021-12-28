import 'package:decornata/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  var mount = 0.0;
  Map<String, CartModel> _items = {};

  //getter cart
  Map<String, CartModel> get items => _items;

  int get mountQty => _items.length;

  void getMount(bool id, CartModel data) {
    if (id == true) {
      mount += data.qty! * num.parse(data.price!).roundToDouble();
    } else if (id == false) {
      mount -= data.qty! * num.parse(data.price!).roundToDouble();
    } else {
      mount = 0.0;
    }
    print(mount);
    notifyListeners();
  }

  void resetMount() {
    mount = 0.0;
  }

  // add product to cart
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
              id: productId, title: title, price: price, image: image, qty: 1));
    }
    notifyListeners();
  }

  void addQuantity(String productId, String title, String price, String image) {
    _items.update(
        productId,
        (value) => CartModel(
            id: value.id,
            title: value.title,
            price: value.price,
            image: value.image,
            qty: value.qty! + 1));

    notifyListeners();
  }

  // delete product on cart
  void deleteCart(String productId, CartModel data, bool select) {
    _items.removeWhere((key, value) => value.id == productId);
    if (select == true) {
      mount = 0.0;
    } else if (mount < 0.0) {
      mount = 0.0;
    } else if (items.isEmpty) {
      mount = 0.0;
    } else if (items.isNotEmpty && select == false && mount > 0.0) {
      print('Select 1');
      mount -= data.qty! * double.parse(data.price!);
    } else if (select == true && mount < 0) {
      print('Select 2');
      mount -= data.qty! * double.parse(data.price!);
    }
    print('Update mount : $mount');
    notifyListeners();
  }
}
