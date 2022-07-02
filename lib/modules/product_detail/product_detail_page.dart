import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/shared/header/header.dart';
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
  ProductModel product = ProductModel(
    id: "id",
    name: "Handcrafted Rubber Towels",
    description:
        "The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality",
    price: "00",
    material: "jj",
    gallery: [
      'http://placeimg.com/640/480/cats',
      'http://placeimg.com/640/480/transport',
      'http://placeimg.com/640/480/nature',
      'http://placeimg.com/640/480/people'
    ],
  );

  void goToShoppingCartPage(BuildContext context, List<ProductModel> products) {
    Navigator.pushNamed(context, "/shoppingcart");
  }

  @override
  Widget build(BuildContext context) {
    // if (ModalRoute.of(context)!.settings.arguments == null) {
    //   Navigator.pushNamed(context, "/home");

    //   return Text('404');
    // }
    final cart = context.watch<CartModel>();

    // product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Header(),
      ),
      body: SingleChildScrollView(
          child: _buildProductDetailsSection(context, cart)),
    );
  }

  _buildProductDetailsSection(BuildContext context, CartModel cart) {
    Size screenSize = MediaQuery.of(context).size;

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
                  SizedBox(
                    height: 8.0,
                  ),
                  _buildProductDescription(),
                  SizedBox(
                    height: 8.0,
                  ),
                  _buildPriceWidget(),
                  SizedBox(
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
    return Container(
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
        autoPlayInterval: Duration(seconds: 4),
        autoPlay: true,
      ),
      items: images.map<Widget>(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                child: Image.network(i, fit: BoxFit.cover),
              );
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
            SizedBox(
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
              goToShoppingCartPage(context, cart.getProducts());
            },
            child: Text('Add to cart', style: TextStyles.bigText),
          ),
        ),
      ],
    );
  }
}
