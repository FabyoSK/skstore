import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/utils/format_currency.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  Widget sliderPlugin(images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlayInterval: Duration(seconds: 4),
        autoPlay: true,
      ),
      items: images.map<Widget>(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 200,
                width: 300,
                child: Image.network(i, fit: BoxFit.cover),
              );
            },
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: product.image != null
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                      )
                    : sliderPlugin(product.gallery),
                height: 200,
                width: 300,
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          FormatCurrency.format(double.parse(product.price)),
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        // Text(
                        //   "$discount\% off",
                        //   style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
