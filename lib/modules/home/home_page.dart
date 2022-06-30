import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/widget/product_list/product_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ProductModel>> getProducts() async {
    final url =
        Uri.parse(ApiEndpoint.resolve_endpoint(ApiEndpoint.get_products));

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ProductModel.allProductFromJson(response.body.toString());
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }

  void goToProductDetailPage(BuildContext context, ProductModel product) {
    Navigator.pushNamed(context, "/product_detail", arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder<List<ProductModel>>(
        future: getProducts(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ProductModel>> snapshot,
        ) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Error2');
            } else if (snapshot.hasData) {
              return ProductList(
                productList: snapshot.data!,
                onCardTap: goToProductDetailPage,
              );
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
