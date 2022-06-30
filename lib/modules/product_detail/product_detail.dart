import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/widget/product_detail/product_detail.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailStatePage();
}

class _ProductDetailStatePage extends State<ProductDetailPage> {
  Future<ProductModel> getProductDetailPage() async {
    // final product_id = ModalRoute.of(context)!.settings.arguments;
    final product_id = "1";

    final url = Uri.parse(
        ApiEndpoint.resolve_endpoint(ApiEndpoint.get_product + product_id));

    final response = await http.get(url);
    final responseJson = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(responseJson);
    } else {
      return Future.error(responseJson["error"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder<ProductModel>(
        future: getProductDetailPage(),
        builder: (
          BuildContext context,
          AsyncSnapshot<ProductModel> snapshot,
        ) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Error2');
            } else if (snapshot.hasData) {
              return ProductDetail(product: snapshot.data!);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
