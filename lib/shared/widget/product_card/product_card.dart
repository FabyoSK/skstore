import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/utils/format_currency.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 300,
                child: product.image != null
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        product.gallery!.first!,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
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
                    Text(product.name, style: TextStyles.textBold),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          FormatCurrency.format(double.parse(product.price)),
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        if (product.hasDiscount != null && product.hasDiscount!)
                          Text(
                            "${double.parse(product.discount!) * 100}% Off",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.blue[700],
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
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
