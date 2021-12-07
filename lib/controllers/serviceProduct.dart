import 'package:flutter/material.dart';
import 'package:decornata/models/product.dart';
import 'package:http/http.dart' as http;

class ServicesProduct extends ChangeNotifier {
  static var client = http.Client();

  static Future<List<Product>?> getProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
