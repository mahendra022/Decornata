import 'package:decornata/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  List<Product>? _product;

  static Future<List<Product>?> getProducts() async {
    var response = await http.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    return null;
  }

  void fatchProduct() async {
    var products = await getProducts();
    if (products != null) {
      this._product = products;
      notifyListeners();
    } else {
      this._product = [];
    }
  }

  List<Product>? get allProduct {
    return _product;
  }
}
