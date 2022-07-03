import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/modules/search/search_controller.dart';
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/widget/product_list/product_list.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchController controller = SearchController();

  String material = "";
  String productName = "";
  int minPrice = 0;
  int maxPrice = 0;

  ValueNotifier<List<ProductModel>> productListNotifier = ValueNotifier([]);

  void restoreLastProductName() async {
    final instance = await SharedPreferences.getInstance();
    productName = instance.getString("lastQuery") ?? "";
  }

  void goToProductDetailPage(BuildContext context, ProductModel product) {
    Navigator.pushNamed(context, "/product_detail", arguments: product);
  }

  void updateMaterial(newValue) {
    material = newValue;
  }

  Widget _buildAutocomplete(
      String labelText, List<String> options, Function onSelected) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return options
                .where((String option) => option
                    .toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase()))
                .toList();
          },
          displayStringForOption: (String option) => option,
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(labelText: "Select $labelText"),
            );
          },
          onSelected: (String selection) {
            onSelected(selection);
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  width: 300,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option, style: TextStyles.text),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchContainer(List<String> materials) {
    print(materials);
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAutocomplete("material", materials, updateMaterial),
            SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(labelText: "Min price"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    minPrice = int.parse(value);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(labelText: "Max price"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    maxPrice = int.parse(value);
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final filteredProducts = await controller.search(
                  name: productName,
                  material: material,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                );
                // print(filteredProducts);
                productListNotifier.value = filteredProducts;
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productName = ModalRoute.of(context)!.settings.arguments as String? ?? "";

    if (productName.isEmpty) restoreLastProductName();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: FutureBuilder<Map<String, List<String>>>(
                future: controller.getCategories(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Map<String, List<String>>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      List<String>? materials = data!["materials"];
                      return _buildSearchContainer(materials!);
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: FutureBuilder<List<ProductModel>>(
                future: controller.search(
                  name: productName,
                  material: material,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                ),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ProductModel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      productListNotifier.value = snapshot.data!;
                      return ValueListenableBuilder(
                        valueListenable: productListNotifier,
                        builder: (BuildContext context,
                            List<ProductModel> productList, _) {
                          return ProductList(
                            productList: productList,
                            onCardTap: goToProductDetailPage,
                          );
                        },
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
