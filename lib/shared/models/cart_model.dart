import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/shared/models/product_model.dart';

class CartModel extends ChangeNotifier {
  late final List<ProductModel> _products = [];

  List<ProductModel> getProducts() => _products;

  void bootstrapInitialProducts() async {
    final instance = await SharedPreferences.getInstance();
    final spProducts =
        json.decode(instance.getString("cart")!) as List<ProductModel>;

    _products.addAll(spProducts);
    // print("FSK $spProducts");
    // print("FSK $_products");
    // if (spProducts.isNotEmpty) {}
  }

  void add(ProductModel item) async {
    _products.add(item);

    final instance = await SharedPreferences.getInstance();
    await instance.setString("cart", json.encode(_products));
    notifyListeners();
  }

  void remove(ProductModel item) async {
    _products.remove(item);
    final instance = await SharedPreferences.getInstance();
    await instance.setString("cart", json.encode(_products));
    notifyListeners();
  }
}
