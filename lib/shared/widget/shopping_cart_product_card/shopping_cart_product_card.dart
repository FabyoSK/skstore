import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';

class ShoppingCartProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onCartButtonTap;
  final VoidCallback onCartRemoveButtonTap;
  final VoidCallback onCartAddButtonTap;

  const ShoppingCartProductCard(
      {Key? key,
      required this.product,
      required this.onTap,
      required this.onCartButtonTap,
      required this.onCartRemoveButtonTap,
      required this.onCartAddButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1.0,
        child: Expanded(
          child: Column(
            children: [
              Row(
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
                        Text(
                          product.name,
                          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),

                            // Text(
                            //   "$discount\% off",
                            //   style: TextStyle(fontSize: 12.0, color: Colors.grey),
                            // ),
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
      ),
    );
  }
}
