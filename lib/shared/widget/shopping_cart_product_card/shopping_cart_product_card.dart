import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';

class ShoppingCartProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onCartButtonTap;
  final VoidCallback onCartRemoveButtonTap;
  final VoidCallback onCartAddButtonTap;

  const ShoppingCartProductCard(
      {Key? key,
      required this.product,
      required this.onCartButtonTap,
      required this.onCartRemoveButtonTap,
      required this.onCartAddButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Expanded(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: TextStyles.textBold,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onCartRemoveButtonTap,
                  icon: const Icon(Icons.remove),
                ),
                Text(product.quantity.toString()),
                IconButton(
                  onPressed: onCartAddButtonTap,
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
