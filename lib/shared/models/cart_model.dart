import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/shared/models/product_model.dart';

class CartModel extends ChangeNotifier {
  late final List<ProductModel> _products = [];

  List<ProductModel> getProducts() => _products;

  CartModel() {
    bootstrapInitialProducts();
  }

  void bootstrapInitialProducts() async {
    final instance = await SharedPreferences.getInstance();
    final spProducts = instance.getString("cart");
    final products = ProductModel.allProductFromJson(spProducts);

    if (products.isNotEmpty) {
      _products.addAll(products);
    }
  }

  void add(ProductModel item) async {
    _products.add(item);

    await saveToSharedPreferences();
    notifyListeners();
  }

  Future<void> saveToSharedPreferences() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("cart", json.encode(_products));
  }

  void remove(ProductModel item) async {
    _products.remove(item);

    await saveToSharedPreferences();
    notifyListeners();
  }

  void setQuantity(index, quantity) async {
    _products[index].quantity = quantity;

    await saveToSharedPreferences();
  }
}
