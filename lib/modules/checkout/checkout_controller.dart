import 'dart:convert';

import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:store/shared/models/user_model.dart';

class CheckoutController {
  Future<void> checkout(
      List<ProductModel> products, CartModel cart, Function callback) async {
    final url = Uri.parse(ApiEndpoint.resolve_endpoint(ApiEndpoint.checkout));

    final body = {
      "products": products
          .map((e) => {
                "id": e.id,
                "supplier_id": e.supplierId,
                "quantity": e.quantity,
                "price": e.price,
                "name": e.name,
                "image_url": e.image ?? e.gallery!.first
              })
          .toList(),
    };

    String accessToken = await UserModel.getAccessToken();

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode(body),
    );

    if (response.statusCode == 204) {
      cart.reset();
      callback();
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }
}
