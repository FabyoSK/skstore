import 'dart:convert';
import 'dart:io';
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/order_model.dart';
import 'package:store/shared/models/user_model.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future<List<Order>> getOrders() async {
    final url = Uri.parse(ApiEndpoint.resolve_endpoint(ApiEndpoint.get_orders));

    String accessToken = await UserModel.getAccessToken();

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return Order.allOrdersFromJson(response.body.toString());
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }
}
