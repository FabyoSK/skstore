import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/product_model.dart';

class SearchController {
  Future<List<ProductModel>> search(
      {required String name,
      String? material,
      int? minPrice,
      int? maxPrice}) async {
    final url = Uri.parse(ApiEndpoint.resolve_endpoint(
        "${ApiEndpoint.search}?name=$name&material=$material&min_price=$minPrice&max_price=$maxPrice"));

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return ProductModel.allProductFromJson(response.body.toString());
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }

  Future<Map<String, List<String>>> getCategories() async {
    final url =
        Uri.parse(ApiEndpoint.resolve_endpoint(ApiEndpoint.get_categories));

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString());
      List<dynamic> materials = json!["materials"];
      List<String> materialList = materials.map((e) => e.toString()).toList();

      final map = <String, List<String>>{};
      map["materials"] = materialList;
      return map;
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }
}
