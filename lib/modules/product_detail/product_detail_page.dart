import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/widget/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductModel product;

  Future<void> _showProductAddedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Item added successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('A new item has been added to your shopping cart.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue shopping'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Go to Shopping cart'),
              onPressed: () {
                goToShoppingCartPage(context);
              },
            ),
          ],
        );
      },
    );
  }

  void goToShoppingCartPage(BuildContext context) {
    Navigator.pushNamed(context, "/shoppingcart");
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return SingleChildScrollView(
        child: _buildProductDetailsSection(context, cart));
  }

  _buildProductDetailsSection(BuildContext context, CartModel cart) {
    return PageWrapper(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                _buildProductImageWidget(),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildProductTitleWidget(),
                  const SizedBox(
                    height: 8.0,
                  ),
                  _buildProductDescription(),
                  const SizedBox(
                    height: 8.0,
                  ),
                  _buildPriceWidget(),
                  const SizedBox(
                    height: 8.0,
                  ),
                  _buildAddToCartButton(context, cart)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductImageWidget() {
    return SizedBox(
      height: 500,
      child: product.image != null
          ? Image.network(
              product.image!,
              fit: BoxFit.cover,
            )
          : sliderPlugin(product.gallery!),
    );
  }

  Widget sliderPlugin(images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 500,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlay: true,
      ),
      items: images.map<Widget>(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(i, fit: BoxFit.cover);
            },
          );
        },
      ).toList(),
    );
  }

  _buildProductTitleWidget() {
    return Text(
      product.name,
      style: TextStyles.title,
      textAlign: TextAlign.left,
    );
  }

  _buildPriceWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "\$${product.price}",
              style: TextStyles.bigTextBold,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              "${product.discount}% Off",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blue[700],
              ),
            )
          ],
        ),
      ],
    );
  }

  _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyles.textBold,
        ),
        Text(
          product.description,
          style: TextStyles.smallText,
        ),
      ],
    );
  }

  _buildAddToCartButton(BuildContext context, CartModel cart) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              cart.add(product);
              _showProductAddedDialog();
            },
            child: Text('Add to cart', style: TextStyles.bigText),
          ),
        ),
      ],
    );
  }
}
