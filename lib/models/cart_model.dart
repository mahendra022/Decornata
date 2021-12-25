import 'package:flutter/foundation.dart';

class CartModel with ChangeNotifier {
  String? id;
  String? title;
  String? price;
  String? image;
  int? qty;
  bool selected;

  CartModel(
      {this.id,
      this.title,
      this.price,
      this.image,
      this.qty,
      this.selected = false});

  void statusSelected() {
    selected = !selected;
    notifyListeners();
  }
}
